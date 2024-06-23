import { withPluginApi } from "discourse/lib/plugin-api";
import { ajax } from "discourse/lib/ajax";

function initializeKpopLottery(api) {
  api.modifyClass("controller:topic", {
    pluginId: "discourse-kpop-lottery",
    actions: {
      startLottery() {
        if (this.currentUser.staff) {
          ajax("/kpop-lottery/start", {
            type: "POST",
            data: { topic_id: this.model.id }
          }).then(() => {
            this.set("lotteryActive", true);
            bootbox.alert("Lottery started successfully!");
          }).catch((error) => {
            bootbox.alert(`Failed to start lottery. Error: ${error.message}`);
          });
        }
      },
      drawLottery() {
        if (this.currentUser.staff) {
          ajax("/kpop-lottery/draw", {
            type: "POST",
            data: { topic_id: this.model.id }
          }).then((result) => {
            bootbox.alert(`Lottery completed! Winner: ${result.winner}`);
          }).catch((error) => {
            bootbox.alert(`Failed to draw lottery. Error: ${error.message}`);
          });
        }
      }
    }
  });

  api.addPostMenuButton("lottery", (post) => {
    if (post.post_number === 1 && post.can_edit) {
      return {
        action: "startLottery",
        icon: "gift",
        className: "lottery-button",
        title: "Start Lottery"
      };
    }
  });
}

export default {
  name: "kpop-lottery",
  initialize() {
    withPluginApi("0.8.31", initializeKpopLottery);
  }
};
