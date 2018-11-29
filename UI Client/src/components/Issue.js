import React, {Component} from 'react';
import Paper from "@material-ui/core/Paper/Paper";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Grid from "@material-ui/core/Grid/Grid";
import Button from "@material-ui/core/Button/Button";
import lime from "@material-ui/core/colors/lime";
import MenuItem from "@material-ui/core/MenuItem/MenuItem";
import Grow from "@material-ui/core/Grow/Grow";
import ClickAwayListener from "@material-ui/core/ClickAwayListener/ClickAwayListener";
import MenuList from "@material-ui/core/MenuList/MenuList";
import Popper from "@material-ui/core/Popper/Popper";
import {yellow} from "@material-ui/core/colors";
import TextField from "@material-ui/core/TextField/TextField";
import red from "@material-ui/core/colors/red";
import Icon from "@material-ui/core/Icon/Icon";
import Divider from "@material-ui/core/Divider/Divider";
import Chip from "@material-ui/core/Chip/Chip";
import config from "../config";
import green from "@material-ui/core/colors/green";
import orange from "@material-ui/core/es/colors/orange";
import CircularProgress from "@material-ui/core/CircularProgress/CircularProgress";
import createMuiTheme from "@material-ui/core/styles/createMuiTheme";
import UserService from "../utils/UserService";
import moment from "moment";

const theme = createMuiTheme();

const styles = {
  editButtonGrid: {
    textAlign: 'right'
  },
  editButton: {
    borderColor: '#fff'
  },
  statusAssigneeGrid: {
    padding: '20px 5px'
  },
  statusButton: {
    marginRight: 15
  },
  nextStatusButton: {
    marginRight: 15,
    color: lime["500"],
    borderColor: lime["500"]
  },
  assigneeButtonGrid: {
    textAlign: 'right'
  },
  assigneeSpan: {
    borderBottom: '2px dotted #212121'
  },
  infoDiv: {
    padding: 20,
    backgroundColor: yellow["100"]
  },
  descDiv: {
    padding: 20,
  },
  commentDiv: {
    padding: 20
  },
  infoHorGrid: {
    padding: 10
  },
  infoItemDiv: {
    display: 'flex',
    alignItems: 'center'
  },
  statusIcon: {
    fontSize: 20
  },
  infoTitle: {
    marginRight: 5
  },
  sendButtonDiv: {
    textAlign: 'right'
  },
  labelChip: {
    fontSize: '9pt',
    height: 18,
    marginRight: 5
  },
  loaderDiv: {
    display: 'flex',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center'
  },
  assigneeToMeButton: {
    color: theme.palette.primary.main
  }
};

export default class Issue extends Component {
  state = {
    assigneeMenuOpen: false,
    issue: {
      priority: 'VERY_LOW',
      assignee: {},
      status: {
        next: [],
        previous: []
      },
      labels: []
    },
    comments: [],
    users: [],
    comment: ''
  };

  loadData(issueId) {
    fetch(`${config.host}/issue-tracker/issues/${issueId}`, {
      headers: {
        'Authorization': `Bearer ${this.props.keycloak.token}`
      }
    })
      .then(res => res.json())
      .then(res => {
        this.setState({issue: res});
        UserService.loadUsers(this.props.keycloak, res.assignee.id, users => this.setState({users: users}))
      });

    fetch(`${config.host}/issue-tracker/comments?issueVisibleId=${issueId}`, {
      headers: {
        'Authorization': `Bearer ${this.props.keycloak.token}`
      }
    })
      .then(res => res.json())
      .then(res => this.setState({comments: res}));
  }

  postComment = () => {
    fetch(`${config.host}/issue-tracker/comments/?issueVisibleId=${this.props.match.params.issueId}`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${this.props.keycloak.token}`,
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        text: this.state.comment
      })
    })
      .then(res => {
        this.loadData(this.props.match.params.issueId);
        this.setState({comment: ''});
      })
  };

  componentDidMount() {
    this.loadData(this.props.match.params.issueId);
  }

  componentWillReceiveProps(props, context) {
    this.loadData(props.match.params.issueId);
  }

  handleMenuToggle = (menuOpen) => {
    this.setState({[menuOpen]: !this.state[menuOpen]});
  };

  handleMenuClose = (event, menuAnchor, menuOpen) => {
    if (menuAnchor.contains(event.target)) return;
    this.setState({[menuOpen]: !this.state[menuOpen]});
  };

  updateStatusReq = (status) => {
    fetch(`${config.host}/issue-tracker/issues/${this.props.match.params.issueId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${this.props.keycloak.token}`
      },
      body: JSON.stringify({
        status: {
          current: status
        }
      })
    })
      .then(() => this.props.history.push(document.location.pathname))
  };

  updateAssigneeReq = (event, assigneeLogin) => {
    fetch(`${config.host}/issue-tracker/issues/${this.props.match.params.issueId}`, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${this.props.keycloak.token}`
      },
      body: JSON.stringify({
        assignee: {
          id: assigneeLogin
        }
      })
    })
      .then(() => {
        this.handleMenuClose(event, this.assigneeMenuAnchor, "assigneeMenuOpen");
        this.props.history.push(document.location.pathname)
      })
  };

  handleCommentChange = (event) => {
    this.setState({comment: event.target.value})
  };

  getPriorityFragment() {
    switch (this.state.issue.priority) {
      case 'VERY_LOW': return (
        <React.Fragment>
          <Icon style={Object.assign({}, styles.statusIcon, {color: green["900"]})} >arrow_downward</Icon>
          <Typography>Very Low</Typography>
        </React.Fragment>
      );

      case 'LOW': return (
        <React.Fragment>
          <Icon style={Object.assign({}, styles.statusIcon, {color: green["200"]})} >expand_more</Icon>
          <Typography>Low</Typography>
        </React.Fragment>
      );

      case 'MEDIUM': return (
        <React.Fragment>
          <Icon style={Object.assign({}, styles.statusIcon, {color: orange["500"]})}>remove</Icon>
          <Typography>Medium</Typography>
        </React.Fragment>
      );

      case 'HIGH': return (
        <React.Fragment>
          <Icon style={Object.assign({}, styles.statusIcon, {color: red["200"]})}>expand_less</Icon>
          <Typography>High</Typography>
        </React.Fragment>
      );

      case 'VERY_HIGH': return (
        <React.Fragment>
          <Icon style={Object.assign({}, styles.statusIcon, {color: red["900"]})}>arrow_upward</Icon>
          <Typography>Very High</Typography>
        </React.Fragment>
      );

      default: console.log("Unexpected priority: " + this.state.issue.priority)
    }
  }

  render() {
    if (this.state.issue.visibleId === undefined) {
      return (
        <div style={styles.loaderDiv}>
          <CircularProgress />
        </div>
      )
    }

    const { assigneeMenuOpen } = this.state;

    return (
      <Paper style={styles.paper}>
        <AppBar position="static" color="primary">
          <Toolbar variant="dense">
            <Grid container alignItems={'center'}>
              <Grid item xs={10}>
                <Typography variant="h6" color="inherit">
                  [{this.state.issue.visibleId}] &nbsp;{this.state.issue.title}
                </Typography>
              </Grid>
              <Grid item xs={2} style={styles.editButtonGrid}>
                <Button
                  variant="outlined"
                  color="inherit"
                  style={styles.editButton}
                  onClick={() => this.props.history.push(`${document.location.pathname}/edit`)}
                >
                  Edit
                </Button>
              </Grid>
            </Grid>
          </Toolbar>
        </AppBar>

        <Grid container alignItems={'center'} style={styles.statusAssigneeGrid}>
          <Grid item xs={10}>
            {this.state.issue.status.previous.map(status => (
              <Button variant="outlined" color="secondary" style={styles.statusButton} onClick={() => this.updateStatusReq(status)}>
                {status}
              </Button>
            ))}

            <Button variant="contained" color="primary" style={styles.statusButton}>{this.state.issue.status.current}</Button>

            {this.state.issue.status.next.map(status => (
              <Button variant="outlined" style={styles.nextStatusButton} onClick={() => this.updateStatusReq(status)}>
                {status}
              </Button>
            ))}
          </Grid>

          <Grid item xs={2} style={styles.assigneeButtonGrid}>
            <Button
              buttonRef={node => { this.assigneeMenuAnchor = node }}
              aria-owns={assigneeMenuOpen ? 'assignee-menu' : undefined}
              aria-haspopup="true"
              onClick={() => this.handleMenuToggle("assigneeMenuOpen")}
            >
              <span style={styles.assigneeSpan}>{this.state.issue.assignee.name}</span>
            </Button>
            <Popper open={assigneeMenuOpen} anchorEl={this.assigneeMenuAnchor} transition>
              {({ TransitionProps }) => (
                <Grow id="assignee-menu"
                      {...TransitionProps}
                      style={{ transformOrigin: 'center bottom' }}
                >
                  <Paper>
                    <ClickAwayListener onClickAway={event => this.handleMenuClose(event, this.assigneeMenuAnchor, "assigneeMenuOpen")}>
                      <MenuList>
                        {this.state.issue.assignee.id !== this.props.keycloak.tokenParsed["preferred_username"] && (
                          <MenuItem style={styles.assigneeToMeButton} onClick={event => this.updateAssigneeReq(event, this.props.keycloak.tokenParsed["preferred_username"])}>
                            Assign to me
                          </MenuItem>
                        )}
                        {this.state.users.map(user => (
                          <MenuItem onClick={event => this.updateAssigneeReq(event, user.id)}>
                            {user.name}
                          </MenuItem>
                        ))}
                      </MenuList>
                    </ClickAwayListener>
                  </Paper>
                </Grow>
              )}
            </Popper>
          </Grid>
        </Grid>

        <div style={styles.infoDiv}>
          <Grid container style={styles.infoHorGrid}>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle1" style={styles.infoTitle}>Priority:</Typography>
                {this.getPriorityFragment()}
              </div>
            </Grid>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle1" style={styles.infoTitle}>Labels:</Typography>
                {this.state.issue.labels.map(label => (
                  <Chip variant="outlined" label={label.value} style={styles.labelChip} />
                ))}
              </div>
            </Grid>
          </Grid>

          <Grid container style={styles.infoHorGrid}>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle1" style={styles.infoTitle}>Epic:</Typography>
                <Typography>None</Typography>
              </div>
            </Grid>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle1" style={styles.infoTitle}>Sprint:</Typography>
                <Typography>None</Typography>
              </div>
            </Grid>
          </Grid>
        </div>

        <div style={styles.descDiv}>
          <Typography align="justify">{this.state.issue.description}</Typography>
        </div>

        <Divider />

        <div id="comment-div" style={styles.commentDiv}>
          <Typography variant="h6">Commentaries</Typography>

          {this.state.comments.map(comment => (
            <TextField
              id="outlined-full-width"
              label={comment.user.name + ', ' + moment(new Date(comment.date)).format("hh:mm DD.MM.YYYY")}
              value={comment.text}
              fullWidth
              disabled
              multiline
              margin="normal"
            />
          ))}

          <TextField
            id="filled-full-width"
            label="Your comment"
            fullWidth
            multiline
            margin="normal"
            variant="outlined"
            value={this.state.comment}
            onChange={this.handleCommentChange}
          />
          <div style={styles.sendButtonDiv}>
            <Button variant="outlined" color="primary" onClick={this.postComment}>Send</Button>
          </div>
        </div>
      </Paper>
    );
  }
}
