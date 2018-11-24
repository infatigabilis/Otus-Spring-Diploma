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
import config from "../config";
import CircularProgress from "@material-ui/core/CircularProgress/CircularProgress";
import Modal from "@material-ui/core/Modal/Modal";
import createMuiTheme from "@material-ui/core/styles/createMuiTheme";
import Divider from "@material-ui/core/Divider/Divider";

const theme = createMuiTheme();

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
    marginBottom: 10,
    minWidth: 100
  },
  loaderDiv: {
    display: 'flex',
    height: '100%',
    alignItems: 'center',
    justifyContent: 'center'
  },
  modal: {
    position: 'absolute',
    width: 700,
    backgroundColor: theme.palette.background.paper,
    boxShadow: theme.shadows[5],
    padding: 20,
    top: '50%',
    left: '50%',
    marginLeft: '-350px',
    marginTop: '-200px',
  }
};

const allLabels = [
  'One',
  'Two',
  'Three',
  'Four',
];

export default class CreateIssue extends Component {
  state = {
    hasErrors: false,
    hasRequestError: false,
    issue: {
      visibleId: '',
      title: '',
      description: '',
      status: '',
      priority: '',
      assignee: {
        id: ''
      },
      labels: []
    },
    error: {}
  };

  pushData = () => {
    if (
      !this.state.issue.visibleId ||
      !this.state.issue.title ||
      !this.state.issue.description ||
      !this.state.issue.status ||
      !this.state.issue.priority ||
      !this.state.issue.assignee.id
    ) {
      this.setState({hasErrors: true});
      return;
    }

    fetch(`${config.host}/issue-tracker/issues`, {
      method: 'POST',
      headers: {'Content-Type': 'application/json'},
      body: JSON.stringify(this.state.issue)
    })
      .then(res => {
        if (res.status === 200) this.props.history.push(`/${this.state.issue.visibleId}`);
        else return res.json()
      })
      .then(errorRes => this.setState({hasRequestError: true, error: errorRes}))
  };

  handleSelectChange = event => {
    const field = event.target.name;
    const value = event.target.value;

    if (event.target.name === 'assignee-id') {
      this.setState(state => {
        state.issue.assignee.id = value;
        return state;
      });
    } else {
      this.setState(state => {
        state.issue[field] = value;
        return state;
      });
    }
  };

  render() {
    return (
      <React.Fragment>
        <Paper>
          <AppBar position="static" color="primary">
            <Toolbar variant="dense">
              <Grid container alignItems={'center'}>
                <Grid item xs={10}>
                  <Typography variant="h6" color="inherit">Creating new issue</Typography>
                </Grid>
                <Grid item xs={2} style={styles.saveButtonGrid}>
                  <Button
                    variant="outlined"
                    color="inherit"
                    style={styles.saveButton}
                    onClick={this.pushData}
                  >
                    Create
                  </Button>
                </Grid>
              </Grid>
            </Toolbar>
          </AppBar>

          <div style={styles.rootDiv}>
            <TextField
              error={this.state.hasErrors && !this.state.issue.visibleId}
              label="Id"
              fullWidth
              required
              value={this.state.issue.visibleId}
              onChange={this.handleSelectChange}
              margin="normal"
              inputProps={{name: 'visibleId'}}
            />
            <TextField
              error={this.state.hasErrors && !this.state.issue.title}
              label="Title"
              fullWidth
              required
              value={this.state.issue.title}
              onChange={this.handleSelectChange}
              margin="normal"
              inputProps={{name: 'title'}}
            />
            <TextField
              error={this.state.hasErrors && !this.state.issue.description}
              required
              label="Description"
              fullWidth
              multiline
              value={this.state.issue.description}
              onChange={this.handleSelectChange}
              margin="normal"
              inputProps={{name: 'description'}}
            />

            <FormControl style={styles.select}>
              <InputLabel>Assignee *</InputLabel>
              <Select
                error={this.state.hasErrors && !this.state.issue.assignee.id}
                value={this.state.issue.assignee.id}
                onChange={this.handleSelectChange}
                inputProps={{name: 'assignee-id'}}
              >
                <MenuItem value={1}>Scott Matthews</MenuItem>
                <MenuItem value={2}>Jake Moore</MenuItem>
                <MenuItem value={3}>Javon Guzman</MenuItem>
                <MenuItem value={4}>Robert Burke</MenuItem>
              </Select>
            </FormControl>
            <br/>

            <FormControl style={styles.select}>
              <InputLabel>Priority *</InputLabel>
              <Select
                error={this.state.hasErrors && !this.state.issue.priority}
                value={this.state.issue.priority}
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
              <InputLabel>Status *</InputLabel>
              <Select
                error={this.state.hasErrors && !this.state.issue.status}
                value={this.state.issue.status}
                onChange={this.handleSelectChange}
                inputProps={{name: 'status'}}
              >
                <MenuItem value={'NEW'}>New</MenuItem>
                <MenuItem value={'ANALISYS'}>Analisys</MenuItem>
                <MenuItem value={'DEVELOPMENT'}>Development</MenuItem>
                <MenuItem value={'REVIEW'}>Review</MenuItem>
                <MenuItem value={'DEPLOYMENT'}>Deployment</MenuItem>
                <MenuItem value={'FEEDBACK'}>Feedback</MenuItem>
                <MenuItem value={'TESTING'}>Testing</MenuItem>
                <MenuItem value={'DONE'}>Done</MenuItem>
                <MenuItem value={'CLOSED'}>Closed</MenuItem>
              </Select>
            </FormControl>
            <br/>

            <FormControl style={styles.select}>
              <InputLabel>Labels</InputLabel>
              <Select
                multiple
                value={this.state.issue.labels ? this.state.issue.labels : []}
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

        <Modal
          aria-labelledby="simple-modal-title"
          aria-describedby="simple-modal-description"
          open={this.state.hasRequestError}
          onClose={() => this.setState({hasRequestError: false})}
        >
          <div style={styles.modal}>
            <Typography variant="h5" color="error">Bad request</Typography>

            <br />
            <Divider />
            <br />

            <Typography variant="subtitle1"><b>Status:</b> {this.state.error.status}</Typography>
            <Typography variant="subtitle1"><b>Message:</b> {this.state.error.message}</Typography>
          </div>
        </Modal>
      </React.Fragment>
    );
  }
}
