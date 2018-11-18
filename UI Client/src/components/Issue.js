import React, {Component} from 'react';
import createMuiTheme from '@material-ui/core/styles/createMuiTheme';
import Paper from "@material-ui/core/Paper/Paper";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import AppBar from "@material-ui/core/AppBar/AppBar";

const theme = createMuiTheme();

const styles = {

};

export default class Issue extends Component {
  render() {
    return (
      <Paper>
        <AppBar position="static" color="primary">
          <Toolbar variant="dense">
            <Typography variant="h6" color="inherit">
              OTUS-12
            </Typography>
          </Toolbar>
        </AppBar>
      </Paper>
    );
  }
}
