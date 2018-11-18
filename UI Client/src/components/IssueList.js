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
  highPriorityIcon: {
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
                  <Icon style={styles.orderByIcon} color="error">arrow_drop_up</Icon>
                </IconButton>
              </Grid>
              <Grid item xs={2} style={styles.issueStateGrid}>
                <IconButton style={styles.orderByButton} component="span">
                  <Icon style={styles.orderByIcon}>arrow_drop_down</Icon>
                </IconButton>
              </Grid>
            </Grid>
          </Toolbar>
        </AppBar>
        <List component="nav">
          <ListItem button style={styles.listItem}>
            <Grid container>
              <Grid item xs={2}>
                <Typography variant="subtitle1"><b>OTUS-1</b></Typography>
              </Grid>
              <Grid item xs={7}>
                <Typography variant="subtitle1" style={styles.issueTitle}>Spring Data MongoDB</Typography>
              </Grid>
              <Grid item xs={1} style={styles.issueStateGrid}>
                <Icon style={Object.assign({}, styles.priorityIcon, {color: red["200"]})} color="error">expand_less</Icon>
              </Grid>
              <Grid item xs={2} style={styles.issueStateGrid}>
                <Chip label="DEVELOPMENT" style={styles.chip} variant="outlined" clickable={true} />
              </Grid>
            </Grid>
          </ListItem>
          <ListItem button selected={true} style={styles.listItem}>
            <Grid container>
              <Grid item xs={2}>
                <Typography variant="subtitle1"><b>OTUS-12</b></Typography>
              </Grid>
              <Grid item xs={7}>
                <Typography variant="subtitle1" style={styles.issueTitle}>Spring Cloud: Config Server, Service Registry</Typography>
              </Grid>
              <Grid item xs={1} style={styles.issueStateGrid}>
                <Icon style={Object.assign({}, styles.highPriorityIcon, {color: red["900"]})} color="error">arrow_upward</Icon>
              </Grid>
              <Grid item xs={2} style={styles.issueStateGrid}>
                <Chip label="REVIEW" style={styles.chip} variant="outlined" clickable={true} />
              </Grid>
            </Grid>
          </ListItem>
          <ListItem button style={styles.listItem}>
            <Grid container>
              <Grid item xs={2}>
                <Typography variant="subtitle1"><b>SPRING-9</b></Typography>
              </Grid>
              <Grid item xs={7}>
                <Typography variant="subtitle1" style={styles.issueTitle}>Spring Batch</Typography>
              </Grid>
              <Grid item xs={1} style={styles.issueStateGrid}>
                <Icon style={Object.assign({}, styles.priorityIcon, {color: green["200"]})} >expand_more</Icon>
              </Grid>
              <Grid item xs={2} style={styles.issueStateGrid}>
                <Chip label="NEW" style={styles.chip} variant="outlined" clickable={true} />
              </Grid>
            </Grid>
          </ListItem>
        </List>
      </Paper>
    );
  }
}
