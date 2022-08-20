import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  tagName: '',
  gameApi: service(),
  flashMessages: service(),

  actions: {
      reloadChar() {
          this.reloadChar();
      },

      econSet(id) {
        let api = this.gameApi;
        api.requestOne('econSet', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.flashMessages.success('Your economy limit has been set! Please reload page to view your economy info.');
                this.send('reloadModel');
            });
       }
   }

});
