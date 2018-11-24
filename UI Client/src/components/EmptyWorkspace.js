import React, {Component} from "react";
import Typography from "@material-ui/core/Typography/Typography";
import grey from "@material-ui/core/colors/grey";

const styles = {
  text: {
    color: grey["400"]
  },
  textDiv: {
    width: '40%',
    textAlign: 'center'
  },
  rootDiv: {
    height: '100%',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center'
  }
};

export default class EmptyWorkspace extends Component {
  render() {
    return (
      <div style={styles.rootDiv}>
        <div style={styles.textDiv}>
          <Typography variant="h4" style={styles.text}>Choose issue from left menu to see it details</Typography>
        </div>
      </div>
    );
  }
}