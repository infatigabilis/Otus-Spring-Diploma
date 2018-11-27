import config from "../config";

export default class UserService {
  static loadUsers(keycloak, currentAssignee, callback) {
    fetch(config.host + '/issue-tracker/users', {
      headers: {
        'Authorization': `Bearer ${keycloak.token}`
      }
    })
      .then(res => res.json())
      .then(res => {
        let result = res
          .filter(user => user.id !== keycloak.tokenParsed["preferred_username"] && user.id !== currentAssignee);

        callback(result)
      })
  }
}