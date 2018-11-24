import React, {Component} from 'react';
import './App.css';
import CssBaseline from "@material-ui/core/CssBaseline/CssBaseline";
import Grid from "@material-ui/core/Grid/Grid";
import IssueList from "./components/IssueList";
import Issue from "./components/Issue";
import TopBar from "./components/TopBar";

const styles = {
  root: {
    flexGrow: 1,
    padding: 12,
    margin: 0,
    width: '100%'
  }
};

export default class App extends Component {
  render() {
    return (
      <React.Fragment>
        <CssBaseline />

        <TopBar />

        <Grid container spacing={24} style={styles.root}>
          <Grid item xs={5} style={styles.grid}>
            <IssueList />
          </Grid>
          <Grid item xs={7} style={styles.grid}>
            <Issue />
          </Grid>
        </Grid>

      </React.Fragment>
    );
  }
}
