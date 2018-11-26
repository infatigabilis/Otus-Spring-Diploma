import React, {Component} from 'react';
import './App.css';
import CssBaseline from "@material-ui/core/CssBaseline/CssBaseline";
import Grid from "@material-ui/core/Grid/Grid";
import IssueList from "./components/IssueList";
import Issue from "./components/Issue";
import TopBar from "./components/TopBar";
import EditIssue from "./components/EditIssue";
import BrowserRouter from "react-router-dom/BrowserRouter";
import Switch from "react-router-dom/Switch";
import Route from "react-router-dom/Route";
import EmptyWorkspace from "./components/EmptyWorkspace";
import CreateIssue from "./components/CreateIssue";
import Review from "./components/Review";
import config from "./config";
import Keycloak from "keycloak-js";
import CircularProgress from "@material-ui/core/CircularProgress/CircularProgress";

const styles = {
  root: {
    flexGrow: 1,
    padding: 12,
    margin: 0,
    width: '100%',
    height: '100%'
  },
  loaderDiv: {
    display: 'flex',
    height: '100%',
    width: '100%',
    alignItems: 'center',
    justifyContent: 'center'
  },
};

export default class App extends Component {
  state = {
    keycloak: Keycloak(config.keycloakSettings),
    authenticated: false
  };

  componentDidMount() {
    this.state.keycloak.init({onLoad: 'login-required'})
      .success(auth => {
        this.setState({authenticated: auth}, () => console.log("Successfully authenticated"))
      })
      .error(e => console.log("Failed to authenticate: " + e));
  }

  render() {
    return (
      <BrowserRouter>
        <React.Fragment>
          <CssBaseline />

          {this.state.authenticated ? (
            <React.Fragment>
              <Route component={(props) => <TopBar {...props} keycloak={this.state.keycloak} />} />

              <Grid container spacing={24} style={styles.root}>
                <Grid item xs={5} style={styles.grid}>
                  <Switch>
                    <Route path='/review/:issueId?' component={(props) => <Review {...props} keycloak={this.state.keycloak} />} />
                    <Route path='/dashboard/:issueId?' component={(props) => <IssueList {...props} keycloak={this.state.keycloak} />} />
                    <Route path='/' component={(props) => <IssueList {...props} keycloak={this.state.keycloak} />} />
                  </Switch>
                </Grid>
                <Grid item xs={7} style={styles.grid}>
                  <Switch>
                    <Route path='/create' component={(props) => <CreateIssue {...props} keycloak={this.state.keycloak} />} />
                    <Route path='/(review|dashboard)/:issueId/edit' component={(props) => <EditIssue {...props} keycloak={this.state.keycloak} />} />
                    <Route path='/(review|dashboard)/:issueId' component={(props) => <Issue {...props} keycloak={this.state.keycloak} />} />
                    <Route path='/' component={(props) => <EmptyWorkspace {...props} keycloak={this.state.keycloak} />} />
                  </Switch>
                </Grid>
              </Grid>
            </React.Fragment>
          ) : (
            <div style={styles.loaderDiv}>
              <CircularProgress />
            </div>
          )}

        </React.Fragment>
      </BrowserRouter>
    );
  }
}
