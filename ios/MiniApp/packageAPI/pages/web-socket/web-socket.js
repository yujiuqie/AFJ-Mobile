// pages/API/web-socket/web-socket.js
function showModal(title, content) {
  wx.showModal({
    title,
    content,
    showCancel: false
  })
}

function showSuccess(title) {
  wx.showToast({
    title,
    icon: 'success',
    duration: 1000
  })
}


Page({
  data: {
    socketStatus: 'closed'
  },

  onLoad() {
    const self = this
    self.setData({
      hasLogin: true
    })
  },

  onUnload() {
    this.closeSocket()
  },

  toggleSocket(e) {
    const turnedOn = e.detail.value

    if (turnedOn && this.data.socketStatus === 'closed') {
      this.openSocket()
    } else if (!turnedOn && this.data.socketStatus === 'connected') {
      const showSuccess = true
      this.closeSocket(showSuccess)
    }
  },

  openSocket() {
    // var socket = this.socket = new qcloud.Tunnel(tunnelUrl)

    wx.onSocketOpen(() => {
      console.log('WebSocket 已连接')
      showSuccess('Socket已连接')
      this.setData({
        socketStatus: 'connected',
        waitingResponse: false
      })
    })

    wx.onSocketClose(() => {
      console.log('WebSocket 已断开')
      this.setData({socketStatus: 'closed'})
    })

    wx.onSocketError(error => {
      showModal('发生错误', JSON.stringify(error))
      console.error('socket error:', error)
      this.setData({
        loading: false
      })
    })

    // 监听服务器推送消息
    wx.onSocketMessage(message => {
      showSuccess('收到信道消息')
      console.log('socket message:', message)
      this.setData({
        loading: false
      })
    })

    // 打开信道
    wx.connectSocket({
      url: 'wss://echo.websocket.org/?encoding=text',
    })
  },

  closeSocket() {
    if (this.data.socketStatus === 'connected') {
      wx.closeSocket({
        success: () => {
          showSuccess('Socket已断开')
          this.setData({socketStatus: 'closed'})
        }
      })
    }
  },

  sendMessage() {
    if (this.data.socketStatus === 'connected') {
      wx.sendSocketMessage({
        data: 'Hello, Miniprogram!'
      })
    }
  },
})
