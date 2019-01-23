import { Controller } from "stimulus"
import channel from "../socket/channel"

export default class extends Controller {

  static targets = ["nameInput", "messageInput", "messageList"]

  connect() {
    channel.on('shout', (payload) => {
      this.insertMessage(payload)
    })
  }

  sendMessage(event) {
    event.preventDefault()
    const nameElement = this.nameInputTarget
    const messageElement = this.messageInputTarget
    channel.push("shout", {
      name: nameElement.value,
      message: messageElement.value
    })
    messageElement.value = null
  }

  insertMessage({name, message}) {
    const element = this.messageListTarget
    element.innerHTML += `<div class="chatContainer_messageList_message">
                            <h5 class="chatContainer_messageList_message_name">${name}</h5>
                            <div class="chatContainer_messageList_message_body">
                              ${message}
                            </div>
                          </div>`
    element.scrollTop = element.scrollHeight
  }
}
