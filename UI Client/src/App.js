import React, {Component} from 'react';
import './App.css';
import CssBaseline from "@material-ui/core/CssBaseline/CssBaseline";
import Grid from "@material-ui/core/Grid/Grid";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import IssueList from "./components/IssueList";

const styles = {
  root: {
    flexGrow: 1,
    padding: 24
  }
};

export default class App extends Component {
  render() {
    return (
      <React.Fragment>
        <CssBaseline />

        <Grid container spacing={24} style={styles.root}>

          <Grid item xs={5} style={styles.grid}>
            <IssueList/>
          </Grid>

          <Grid item xs={7} style={styles.grid}>
            <AppBar position="static" color="primary">
              <Toolbar variant="dense">
                <Typography variant="h6" color="inherit">
                  OTUS-12
                </Typography>
              </Toolbar>
            </AppBar>
          </Grid>

        </Grid>

      </React.Fragment>
    );
  }
}
