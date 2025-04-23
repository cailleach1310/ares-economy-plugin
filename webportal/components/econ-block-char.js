import EmberObject, { computed, action } from '@ember/object';
import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
    gameApi: service(),
    flashMessages: service(),
    router: service(),
    tagName: '',
    pcBlockName: null,
    pcBlockReason: null,
    pcBlockDays: 0,

   @action
   cancelEconBlock() {
     this.set('setEconBlock', false);
   },

   @action
   doEconBlock() {
     let api = this.gameApi;
   
     let pcBlockName = this.blockName;
     let pcBlockDays = this.blockDays;
     let pcBlockReason = this.blockReason;

     if (pcBlockName == null) {
        this.flashMessages.danger("You haven't entered a name.");
        return;
     }
     
     if (pcBlockReason == null) {
        this.flashMessages.danger("You haven't entered a block reason.");
        return;
     }

     if (pcBlockDays < 1) {
        this.flashMessages.danger("Invalid block duration.");
        return;
     }

     this.set('setEconBlock',false);
     this.set('pcBlockName', null);
     this.set('pcBlockReason', null);
     this.set('pcBlockDays', 0);

     api.requestOne('econBlock', { name: pcBlockName,
         reason: pcBlockReason,
         days: pcBlockDays }, null)
      .then( (response) => {
        if (response.error) {
           return;
        }
        this.router.transitionTo('char', response.name);
        this.flashMessages.success('Econ block has been set!');
      }); 
   }

});
