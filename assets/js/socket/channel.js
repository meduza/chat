import {Socket} from "phoenix"
import socket from "./socket"

let channel = socket.channel("room:main", {})
    channel.join()
      .receive("ok", resp => {
        console.log("Socket joined successfully", resp)
      })
      .receive("error", resp => {
        console.log("Unable to join socket", resp)
      })

export default channel
