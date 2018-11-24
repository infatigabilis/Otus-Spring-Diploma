import React, {Component} from 'react';
import Paper from "@material-ui/core/Paper/Paper";
import Toolbar from "@material-ui/core/Toolbar/Toolbar";
import Typography from "@material-ui/core/Typography/Typography";
import AppBar from "@material-ui/core/AppBar/AppBar";
import Grid from "@material-ui/core/Grid/Grid";
import Button from "@material-ui/core/Button/Button";
import MenuItem from "@material-ui/core/MenuItem/MenuItem";
import TextField from "@material-ui/core/TextField/TextField";
import FormControl from "@material-ui/core/FormControl/FormControl";
import InputLabel from "@material-ui/core/InputLabel/InputLabel";
import Select from "@material-ui/core/Select/Select";

const styles = {
  saveButtonGrid: {
    textAlign: 'right'
  },
  saveButton: {
    borderColor: '#fff'
  },
  rootDiv: {
    padding: 20
  },
  select: {
    marginTop: 10,
    marginBottom: 10
  }
};

const allLabels = [
  'One',
  'Two',
  'Three',
  'Four',
];

export default class EditIssue extends Component {
  state = {
    visibleId: 'OTUS-12',
    title: 'Spring Cloud: Config Server, Service Registry, Proxy',
    desc: 'Sample desc',
    assignee: 1,
    status: 'NEW',
    priority: 'MEDIUM',
    labels: ['One', "Three"]
  };

  handleSelectChange = event => {
    this.setState({ [event.target.name]: event.target.value });
  };

  render() {
    return (
      <Paper>
        <AppBar position="static" color="primary">
          <Toolbar variant="dense">
            <Grid container alignItems={'center'}>
              <Grid item xs={10}>
                <Typography variant="h6" color="inherit">
                  Edit issue
                </Typography>
              </Grid>
              <Grid item xs={2} style={styles.saveButtonGrid}>
                <Button variant="outlined" color="inherit" style={styles.saveButton}>Save</Button>
              </Grid>
            </Grid>
          </Toolbar>
        </AppBar>

        <div style={styles.rootDiv}>
          <TextField
            id="standard-name"
            label="Id"
            fullWidth
            value={this.state.visibleId}
            onChange={this.handleSelectChange}
            margin="normal"
            inputProps={{name: 'visibleId'}}
          />
          <TextField
            id="standard-name"
            label="Title"
            fullWidth
            value={this.state.title}
            onChange={this.handleSelectChange}
            margin="normal"
            inputProps={{name: 'title'}}
          />
          <TextField
            id="standard-name"
            label="Description"
            fullWidth
            multiline
            value={this.state.desc}
            onChange={this.handleSelectChange}
            margin="normal"
            inputProps={{name: 'desc'}}
          />

          <FormControl style={styles.select}>
            <InputLabel>Assignee</InputLabel>
            <Select
              value={this.state.assignee}
              onChange={this.handleSelectChange}
              inputProps={{name: 'assignee'}}
            >
              <MenuItem value={1}>Scott Matthews</MenuItem>
              <MenuItem value={2}>Jake Moore</MenuItem>
              <MenuItem value={3}>Javon Guzman</MenuItem>
              <MenuItem value={4}>Robert Burke</MenuItem>
            </Select>
          </FormControl>
          <br/>

          <FormControl style={styles.select}>
            <InputLabel>Priority</InputLabel>
            <Select
              value={this.state.priority}
              onChange={this.handleSelectChange}
              inputProps={{name: 'priority'}}
            >
              <MenuItem value={'VERY_LOW'}>Very Low</MenuItem>
              <MenuItem value={'LOW'}>Low</MenuItem>
              <MenuItem value={'MEDIUM'}>Medium</MenuItem>
              <MenuItem value={'HIGH'}>High</MenuItem>
              <MenuItem value={'VERY_HIGH'}>Very High</MenuItem>
            </Select>
          </FormControl>
          <br/>

          <FormControl style={styles.select}>
            <InputLabel>Status</InputLabel>
            <Select
              value={this.state.status}
              onChange={this.handleSelectChange}
              inputProps={{name: 'status'}}
            >
              <MenuItem value={'NEW'}>New</MenuItem>
              <MenuItem value={'ANALISYS'}>Analisys</MenuItem>
              <MenuItem value={'DEVELOPMENT'}>Development</MenuItem>
              <MenuItem value={'REVIEW'}>Review</MenuItem>
              <MenuItem value={'DEPLOYMENT'}>Deployment</MenuItem>
              <MenuItem value={'DONE'}>Done</MenuItem>
              <MenuItem value={'CLOSED'}>Closed</MenuItem>
            </Select>
          </FormControl>
          <br/>

          <FormControl style={styles.select}>
            <InputLabel>Labels</InputLabel>
            <Select
              multiple
              value={this.state.labels}
              onChange={this.handleSelectChange}
              inputProps={{name: 'labels'}}
            >
              {allLabels.map(label => (
                <MenuItem key={label} value={label}>
                  {label}
                </MenuItem>
              ))}
            </Select>
          </FormControl>
        </div>
      </Paper>
    );
  }
}
