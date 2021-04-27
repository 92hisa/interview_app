<template>
<div id="app">
  <div class="lead-text text-center">
    <span>① マイクとカメラを設定 (選択すると自動でwebカメラが起動します。)</span>
  </div>

  <div class="d-sm-flex align-items-center justify-content-between flex-sm-xs-column">
  <div class="m-1">
    <span class="camera-option mb-3 text-center">
      <span class="mr-3">マイク:</span>
      <select v-model="selectedAudio" @change="onChange" style="width: 200px;">
        <option disabled value="">Please select one</option>
        <option v-for="(audio, key, index) in audios" v-bind:key="index" :value="audio.value">
          {{ audio.text }}
        </option>
      </select>
    </span>
  </div>
  <div class="m-1">
    <span class="camera-option mb-3 text-center">
      <span class="mr-3">カメラ:</span>
      <select v-model="selectedVideo" @change="onChange" style="width: 200px;">
        <option disabled value="">Please select one</option>
        <option v-for="(video, key, index) in videos" v-bind:key="index" :value="video.value">
          {{ video.text }}
        </option>
      </select>
    </span>
  </div>
  </div>

  <div class="card">
      <div class="card-body p-0 mt-2 text-center">
        <video id="their-video" class="border" style="width: 100%; max-width: 1000px;" autoplay playsinline></video>
      </div>
      <div class="card-body p-0 mb-2 d-flex justify-content-center">
        <video id="my-video" muted="true" class="border" style="width: 200px;" autoplay playsinline></video>
      </div>
  </div>

  <p class="mt-3" style="font-size: 20px;">
    あなたのPeer ID: <span id="my-id">{{ peerId }}</span>
  </p>

  <div class="lead-text text-center">
    <span>② お相手のPeer IDを入力して、 通話開始をクリック(しばらくすると、ビデオ通話が開始します。)</span>
  </div>

  <div class="call-area d-flex align-items-center justify-content-center">
    <input v-model="calltoid" placeholder="相手のIDを入力してください" class="video-chat-form" style="width: 300px;"/>
  </div>
  <div class="mt-3 text-center">
    <button @click="makeCall" class="btn btn-success btn-sm">通話開始</button>
    <input type="button" value="通話終了" class="btn btn-outline-danger btn-sm ml-2" onclick="window.location.reload();" />
  </div>
</div>
</template>

<script>
const API_KEY = process.env.SKY_WAY_API_KEY;
// const Peer = require('../skyway-js');
console.log(Peer);
export default {
  data: function () {
    return {
      audios: [],
      videos: [],
      selectedAudio: "",
      selectedVideo: "",
      peerId: "",
      calltoid: "",
      localStream: {},
    };
  },
  methods: {
    onChange: function () {
      if (this.selectedAudio != "" && this.selectedVideo != "") {
        this.connectLocalCamera();
      }
    },

    connectLocalCamera: async function () {
      const constraints = {
        audio: this.selectedAudio
          ? { deviceId: { exact: this.selectedAudio } }
          : false,
        video: this.selectedVideo
          ? { deviceId: { exact: this.selectedVideo } }
          : false,
      };

      const stream = await navigator.mediaDevices.getUserMedia(constraints);
      document.getElementById("my-video").srcObject = stream;
      this.localStream = stream;
    },

    makeCall: function () {
      const call = this.peer.call(this.calltoid, this.localStream);
      this.connect(call);
    },

    connect: function (call) {
      call.on("stream", (stream) => {
        const el = document.getElementById("their-video");
        el.srcObject = stream;
        el.play();
      });
    },
  },

  created: async function () {
    this.peer = new Peer({ key: API_KEY, debug: 3 }); //新規にPeerオブジェクトの作成
    this.peer.on("open", () => (this.peerId = this.peer.id)); //PeerIDを反映
    this.peer.on("call", (call) => {
      call.answer(this.localStream);
      this.connect(call);
    });

    const constraints = { audio: true, video: { width: 1280, height: 720 } };

    // カメラの許可をとる
    const userMedia = await navigator.mediaDevices.getUserMedia(constraints);

    let deviceInfos;
    if (userMedia.active) {
      //デバイスへのアクセス
      deviceInfos = await navigator.mediaDevices.enumerateDevices();
    }

    //オーディオデバイスの情報を取得
    deviceInfos
      .filter((deviceInfo) => deviceInfo.kind === "audioinput")
      .map((audio) =>
        this.audios.push({
          text: audio.label || `Microphone ${this.audios.length + 1}`,
          value: audio.deviceId,
        })
      );

    //カメラの情報を取得
    deviceInfos
      .filter((deviceInfo) => deviceInfo.kind === "videoinput")
      .map((video) => {
        this.videos.push({
          text: video.label || `Camera  ${this.videos.length - 1}`,
          value: video.deviceId,
        });
      });
  },
};
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
.call-area {
  margin-left: 30px;
  margin-bottom: 30px;
}
.option-area {
  margin: 0px 30px;
}
.camera-option {
  margin-left: 20px;
  margin-bottom: 10px;
}
.call-btn {
  cursor: pointer;
  height: 29px;
  margin-left: 5px;
  background-color: #6795fd;
  color: #fff;
  padding-right: 10px;
  padding-left: 10px;
}
.video-chat-form {
  padding: 5px;
  width: 200px;
}
.lead-text {
  margin: 30px 30px 20px;
}
</style>
