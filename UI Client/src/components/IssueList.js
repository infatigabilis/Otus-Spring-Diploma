import React, {Component} from 'react';
import Grid from "@material-ui/core/Grid/Grid";
import createMuiTheme from '@material-ui/core/styles/createMuiTheme';
import AppBar from "@material-ui/core/AppBar/AppBar";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import List from "@material-ui/core/List/List";
import ListItem from "@material-ui/core/ListItem/ListItem";
import green from "@material-ui/core/colors/green";
import Chip from "@material-ui/core/Chip/Chip";
import Icon from "@material-ui/core/Icon/Icon";
import IconButton from "@material-ui/core/IconButton/IconButton";
import Paper from "@material-ui/core/Paper/Paper";
import red from "@material-ui/core/colors/red";
import orange from "@material-ui/core/es/colors/orange";
import config from '../config';

const theme = createMuiTheme();

const styles = {
  listItem: {
    paddingBottom: 4
  },
  chip: {
    marginLeft: theme.spacing.unit,
    fontSize: 11,
    height: 23,
  },
  priorityIcon: {
    fontSize: 40,
    margin: '-7px 0 -6px 0'
  },
  bigPriorityIcon: {
    fontSize: 30,
    margin: '-2px 0 -1px 0'
  },
  issueTitle: {
    marginLeft: 10
  },
  issueStateGrid: {
    textAlign: 'center'
  },
  orderByLabel: {
    textAlign: 'right'
  },
  orderByIcon: {
    color: '#fff',
    fontSize: 30
  },
  orderByButton: {
    height: 30,
    width: 30
  }
};

export default class IssueList extends Component {

  state = {
    issues: [],
    priorityDirection: null,
    statusDirection: null
  };

  loadData() {
    fetch(
      config.host + '/issue-tracker/issues?assigneeId=1' +
      (this.state.priorityDirection ? '&priorityDirection=' + this.state.priorityDirection : '') +
      (this.state.statusDirection ? '&statusDirection=' + this.state.statusDirection : '')
    )
      .then(res => res.json())
      .then(res => this.setState({issues: res}))
  }

  componentDidMount() {
    this.loadData()
  }

  componentWillReceiveProps(props, context) {
    this.loadData()
  }

  getPriorityIcon(priorityName) {
    switch (priorityName) {
      case 'VERY_LOW': return (
          <Icon style={Object.assign({}, styles.bigPriorityIcon, {color: green["900"]})} >arrow_downward</Icon>
      );

      case 'LOW': return (
          <Icon style={Object.assign({}, styles.priorityIcon, {color: green["200"]})} >expand_more</Icon>
      );

      case 'MEDIUM': return (
        <Icon style={Object.assign({}, styles.bigPriorityIcon, {color: orange["500"]})}>remove</Icon>
      );

      case 'HIGH': return (
        <Icon style={Object.assign({}, styles.priorityIcon, {color: red["200"]})}>expand_less</Icon>
      );

      case 'VERY_HIGH': return (
        <Icon style={Object.assign({}, styles.bigPriorityIcon, {color: red["900"]})}>arrow_upward</Icon>
      );

      default: console.log("Unexpected priority: " + priorityName)
    }
  }

  getOrderByIcon(value) {
    if (value === 'DESC') {
      return 'arrow_drop_up'
    } else if (value === 'ASC') {
      return 'arrow_drop_down'
    } else {
      return 'remove'
    }
  }

  handleOrderByToggle(stateField) {
    if (this.state[stateField] === 'ASC') {
      this.setState(prev => {
        prev[stateField] = 'DESC';
        return prev;
      }, this.loadData)
    } else if (this.state[stateField] === 'DESC') {
      this.setState(prev => {
        prev[stateField] = null;
        return prev;
      }, this.loadData)
    } else {
      this.setState(prev => {
        prev[stateField] = 'ASC';
        return prev;
      }, this.loadData)
    }
  }

  render() {
    return (
      <Paper>

        <AppBar position="static" color="primary">
          <Toolbar variant="dense">
            <Grid container alignItems={'center'}>
              <Grid item xs={9}>
                <Typography variant="h6" color="inherit">Your issues</Typography>
              </Grid>
              <Grid item xs={1} style={styles.issueStateGrid}>
                <IconButton style={styles.orderByButton} component="span">
                  <Icon onClick={() => this.handleOrderByToggle('priorityDirection')} style={styles.orderByIcon}>
                    {this.getOrderByIcon(this.state.priorityDirection)}
                    </Icon>
                </IconButton>
              </Grid>
              <Grid item xs={2} style={styles.issueStateGrid}>
                <IconButton style={styles.orderByButton} component="span">
                  <Icon onClick={() => this.handleOrderByToggle('statusDirection')}  style={styles.orderByIcon}>
                    {this.getOrderByIcon(this.state.statusDirection)}
                    </Icon>
                </IconButton>
              </Grid>
            </Grid>
          </Toolbar>
        </AppBar>

        <List component="nav">
          {this.state.issues.map(issue => (
            <ListItem
              key={issue.visibleId}
              button style={styles.listItem}
              onClick={() => this.props.history.push(`/${issue.visibleId}`)}
              selected={this.props.match.params.issueId === issue.visibleId}
            >
              <Grid container>
                <Grid item xs={2}>
                  <Typography variant="subtitle1"><b>{issue.visibleId}</b></Typography>
                </Grid>
                <Grid item xs={7}>
                  <Typography variant="subtitle1" style={styles.issueTitle}>{issue.title}</Typography>
                </Grid>
                <Grid item xs={1} style={styles.issueStateGrid}>
                  {this.getPriorityIcon(issue.priority)}
                </Grid>
                <Grid item xs={2} style={styles.issueStateGrid}>
                  <Chip label={issue.status} style={styles.chip} variant="outlined" clickable={true} />
                </Grid>
              </Grid>
            </ListItem>
          ))}
        </List>
      </Paper>
    );
  }
}
