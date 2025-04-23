import { computed, action } from '@ember/object';
import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  gameApi: service(),
  flashMessages: service(),
  router: service(),
  setEconBlock: false,
  chars: computed('model{investors,titles}', function () {
        let titles = this.get('model.titles');
        let investors = this.get('model.investors');
        let chars = [];
        investors.forEach(function(char_fields) {
            let char = [];
            titles.forEach(function(title) {
                let field = char_fields[title];
                char.push(field);
            });
            chars.push(char);
        });
        return chars;
    }),

  @action
  doSetEconBlock() {
    this.set('setEconBlock', true);
  },

  @action
  econUnblock(id) {
    let api = this.gameApi;
    api.requestOne('econUnblock', { name: id }, null)
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.router.transitionTo('char', response.name);
            this.flashMessages.success('Econ block has been removed!');
        });
  },

  @action
  econClearAll() {
    let api = this.gameApi;
    api.requestOne('econClearAll', {}, null)
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.flashMessages.success('All econ limits have been cleared!');
            this.send('reloadModel');
        });
  },

  @action
  econReset(id) {
    let api = this.gameApi;
    api.requestOne('econReset', { name: id }, null)
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.router.transitionTo('char',response.name);
            this.flashMessages.success('Econ limit has been reset!');
        });
  }
});
