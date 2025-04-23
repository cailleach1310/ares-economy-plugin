import Component from '@ember/component';
import { action } from '@ember/object';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  gameApi: service(),
  flashMessages: service(),
  
  @action
  reloadChar() {
    this.onReloadChar();
  },
  
  @action
  econSet(id) {
    let api = this.gameApi;
    api.requestOne('econSet', { name: id }, null)
        .then( (response) => {
            if (response.error) {
                return;
            }
            this.flashMessages.success('Your economy limit has been set!');
            this.reloadChar();
        });
  }
  
});
