import React, {Component} from 'react';
import createMuiTheme from '@material-ui/core/styles/createMuiTheme';
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Grid from "@material-ui/core/Grid/Grid";
import Button from "@material-ui/core/Button/Button";
import MenuItem from "@material-ui/core/MenuItem/MenuItem";
import Grow from "@material-ui/core/Grow/Grow";
import ClickAwayListener from "@material-ui/core/ClickAwayListener/ClickAwayListener";
import Paper from "@material-ui/core/Paper/Paper";
import MenuList from "@material-ui/core/MenuList/MenuList";
import Popper from "@material-ui/core/Popper/Popper";

const theme = createMuiTheme();

const styles = {
  accountGrid: {
    textAlign: 'right'
  },
  createIssueMenuItem: {
    color: theme.palette.primary.main
  },
  logoutMenuItem: {
    color: theme.palette.error.main
  }
};

export default class TopBar extends Component {
  state = {
    issuesMenuOpen: false,
    accountMenuOpen: false
  };

  handleMenuToggle = (menuOpen) => {
    this.setState({[menuOpen]: !this.state[menuOpen]});
  };

  handleMenuClose = (event, menuAnchor, menuOpen) => {
    if (menuAnchor.contains(event.target)) return;
    this.setState({[menuOpen]: !this.state[menuOpen]});
  };

  render() {
    const { issuesMenuOpen } = this.state;
    const { accountMenuOpen } = this.state;

    return (
      <AppBar position="static" color="default">
        <Toolbar variant="dense">
          <Grid container alignItems={'center'}>

            <Grid item xs={2}>
              <Typography variant="h5">
                <b>Otus-Spring-Diploma</b>
              </Typography>
            </Grid>

            <Grid item xs={7}>
              <div>

                <Button disabled>Projects</Button>

                <Typography style={{display: 'inline'}}>|</Typography>

                <Button
                  buttonRef={node => { this.issuesMenuAnchor = node }}
                  aria-owns={issuesMenuOpen ? 'issues-menu' : undefined}
                  aria-haspopup="true"
                  onClick={() => this.handleMenuToggle("issuesMenuOpen")}
                >
                  Issues
                </Button>
                <Popper open={issuesMenuOpen} anchorEl={this.issuesMenuAnchor} transition>
                  {({ TransitionProps }) => (
                    <Grow id="issues-menu"
                          {...TransitionProps}
                          style={{ transformOrigin: 'left bottom' }}
                    >
                      <Paper>
                        <ClickAwayListener onClickAway={event => this.handleMenuClose(event, this.issuesMenuAnchor, "issuesMenuOpen")}>
                          <MenuList>
                            <MenuItem onClick={() => this.props.history.push('/')}>
                              Dashboard
                            </MenuItem>
                            <MenuItem onClick={() => this.props.history.push('/review')}>
                              Review
                            </MenuItem>
                            <MenuItem
                              style={styles.createIssueMenuItem}
                              onClick={() => this.props.history.push('/create')}
                            >
                              Create new
                            </MenuItem>
                          </MenuList>
                        </ClickAwayListener>
                      </Paper>
                    </Grow>
                  )}
                </Popper>

                <Typography style={{display: 'inline'}}>|</Typography>

                <Button disabled>Agile</Button>

              </div>
            </Grid>

            <Grid item xs={3} style={styles.accountGrid}>
              <Button
                variant="outlined"
                buttonRef={node => { this.accountMenuAnchor = node }}
                aria-owns={accountMenuOpen ? 'account-menu' : undefined}
                aria-haspopup="true"
                onClick={() => this.handleMenuToggle("accountMenuOpen")}
              >
                Scott Matthews | user1@mail.com
              </Button>
              <Popper open={accountMenuOpen} anchorEl={this.accountMenuAnchor} transition>
                {({ TransitionProps }) => (
                  <Grow id="account-menu"
                        {...TransitionProps}
                        style={{ transformOrigin: 'left bottom' }}
                  >
                    <Paper>
                      <ClickAwayListener onClickAway={event => this.handleMenuClose(event, this.accountMenuAnchor, "accountMenuOpen")}>
                        <MenuList>
                          <MenuItem
                            style={styles.logoutMenuItem}
                            onClick={event => this.handleMenuClose(event, this.accountMenuAnchor, "accountMenuOpen")}
                          >
                            Logout
                          </MenuItem>
                        </MenuList>
                      </ClickAwayListener>
                    </Paper>
                  </Grow>
                )}
              </Popper>

            </Grid>
          </Grid>
        </Toolbar>
      </AppBar>
    );
  }
}
