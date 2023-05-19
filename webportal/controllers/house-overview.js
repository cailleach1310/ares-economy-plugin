import { computed } from '@ember/object';
import Controller from '@ember/controller';
import { inject as service } from '@ember/service';

export default Controller.extend({
  gameApi: service(),
  flashMessages: service(),
  router: service(),
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

    actions: {

      EconSet(id) {
        let api = this.gameApi;
//        let char_name = id.split(" ")[0]; 
//        api.requestOne('econSet', { name: char_name }, null)
        api.requestOne('econSet', { name: id }, null)
            .then( (response) => {
                if (response.error) {
                    return;
                }
                this.router.transitionTo('char', response.name);
                this.flashMessages.success('You have set the econ limit for ' + response.name);
            });
      }
   }
});
