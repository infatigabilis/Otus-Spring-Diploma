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
    display: 'flex'
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
  }
};

export default class Issue extends Component {
  state = {
    assigneeMenuOpen: false,
  };

  handleMenuToggle = (menuOpen) => {
    this.setState(state => {
      state[menuOpen] = !state[menuOpen];
      return state;
    });
  };

  handleMenuClose = (event, menuAnchor, menuOpen) => {
    if (menuAnchor.contains(event.target)) {
      return;
    }

    this.setState(state => {
      state[menuOpen] = !state[menuOpen];
      return state;
    });
  };

  render() {
    const { assigneeMenuOpen } = this.state;

    return (
      <Paper style={styles.paper}>
        <AppBar position="static" color="primary">
          <Toolbar variant="dense">
            <Grid container alignItems={'center'}>
              <Grid item xs={10}>
                <Typography variant="h6" color="inherit">
                  [OTUS-12] &nbsp;Spring Cloud: Config Server, Service Registry, Proxy
                </Typography>
              </Grid>
              <Grid item xs={2} style={styles.editButtonGrid}>
                <Button variant="outlined" color="inherit" style={styles.editButton}>Edit</Button>
              </Grid>
            </Grid>
          </Toolbar>
        </AppBar>

        <Grid container alignItems={'center'} style={styles.statusAssigneeGrid}>
          <Grid item xs={10}>
            <Button color="secondary" style={styles.statusButton}>To Analise</Button>
            <Button variant="contained" color="primary" style={styles.statusButton}>Development</Button>
            <Button variant="outlined" color="action" style={styles.nextStatusButton}>To Review</Button>
            <Button variant="outlined" style={styles.nextStatusButton}>To Testing</Button>
          </Grid>

          <Grid item xs={2} style={styles.assigneeButtonGrid}>
            <Button
              buttonRef={node => { this.assigneeMenuAnchor = node }}
              aria-owns={assigneeMenuOpen ? 'assignee-menu' : undefined}
              aria-haspopup="true"
              onClick={() => this.handleMenuToggle("assigneeMenuOpen")}
            >
              <span style={styles.assigneeSpan}>Jake Moore</span>
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
                        <MenuItem onClick={event => this.handleMenuClose(event, this.assigneeMenuAnchor, "assigneeMenuOpen")}>
                          Assign to me
                        </MenuItem>
                        <MenuItem onClick={event => this.handleMenuClose(event, this.assigneeMenuAnchor, "assigneeMenuOpen")}>
                          Javon Guzman
                        </MenuItem>
                        <MenuItem onClick={event => this.handleMenuClose(event, this.assigneeMenuAnchor, "assigneeMenuOpen")}>
                          Robert Burke
                        </MenuItem>
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
                <Typography variant="subtitle" style={styles.infoTitle}>Priority:</Typography>
                <Icon style={Object.assign({}, styles.statusIcon, {color: red["900"]})} color="error">arrow_upward</Icon>
                <Typography>Very High</Typography>
              </div>
            </Grid>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle" style={styles.infoTitle}>Labels:</Typography>
                <Chip variant="outlined" label="One" style={styles.labelChip} />
                <Chip variant="outlined" label="Two" style={styles.labelChip} />
                <Chip variant="outlined" label="Three" style={styles.labelChip} />
              </div>
            </Grid>
          </Grid>

          <Grid container style={styles.infoHorGrid}>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle" style={styles.infoTitle}>Epic:</Typography>
                <Typography>None</Typography>
              </div>
            </Grid>
            <Grid item xs={6}>
              <div style={styles.infoItemDiv}>
                <Typography variant="subtitle" style={styles.infoTitle}>Sprint:</Typography>
                <Typography>None</Typography>
              </div>
            </Grid>
          </Grid>
        </div>

        <div style={styles.descDiv}>
          <Typography align="justify">
            Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ante massa, aliquet sed enim vel, commodo ultricies est. Pellentesque scelerisque turpis tortor, id semper tellus venenatis in. Curabitur mollis leo a mi consequat commodo. Fusce mauris turpis, commodo eget arcu elementum, faucibus ultricies nisi. In eget rutrum arcu, bibendum imperdiet tortor. Nunc in congue leo. Proin molestie sem enim, vel euismod sem sodales ut. Vivamus dignissim erat urna, non feugiat diam vulputate ut. Donec vitae dui interdum, vulputate sapien nec, convallis magna. Sed rhoncus odio eget tristique mollis. Duis venenatis metus non neque pulvinar, id vulputate nisl lacinia.
          </Typography>
        </div>

        <Divider />

        <div id="comment-div" style={styles.commentDiv}>
          <Typography variant="h6">Commentaries</Typography>

          <TextField
            id="outlined-full-width"
            label="Ivanov Danil, 20.11.18"
            value="Suspendisse ac commodo lacus. Donec nulla magna, euismod sed leo at, tempus pellentesque eros. Donec pellentesque nulla ac sem feugiat, vitae molestie nulla dapibus. Praesent volutpat at ligula ac dignissim. Donec sit amet lacinia purus. Quisque a mauris eleifend, tempor arcu feugiat, hendrerit massa. Maecenas consequat tempor fringilla"
            fullWidth
            disabled
            multiline
            margin="normal"
          />
          <TextField
            id="outlined-full-width"
            label="Ivanov Danil, 20.11.18"
            value="Etiam tincidunt cursus tortor, a consequat nisi tincidunt vitae. Vestibulum mollis urna a metus lobortis bibendum. Quisque porttitor urna nec mollis ultrices. Nullam condimentum ex ligula, a accumsan ligula consequat ut"
            fullWidth
            disabled
            multiline
            margin="normal"
          />
          <TextField
            id="outlined-full-width"
            label="Ivanov Danil, 23.11.18"
            value="Done. Created merge request"
            fullWidth
            disabled
            multiline
            margin="normal"
          />
          <TextField
            id="outlined-full-width"
            label="Ivanov Danil, 24.11.18"
            value="Released version 0.1.12"
            fullWidth
            disabled
            multiline
            margin="normal"
          />

          <TextField
            id="filled-full-width"
            label="Your comment"
            fullWidth
            multiline
            margin="normal"
            variant="outlined"
          />
          <div style={styles.sendButtonDiv}>
            <Button variant="outlined" color="primary">Send</Button>
          </div>
        </div>
      </Paper>
    );
  }
}
