// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "assets/js/app.js".

// To use Phoenix channels, the first step is to import Socket,
// and connect at the socket path in "lib/web/endpoint.ex".
//
// Pass the token on params as below. Or remove it
// from the params if you are not using authentication.
import {Socket} from "phoenix"
import * as PIXI from "pixi.js";

let socket = new Socket("/socket", {params: {token: window.userToken}})

// When you connect, you'll often need to authenticate the client.
// For example, imagine you have an authentication plug, `MyAuth`,
// which authenticates the session and assigns a `:current_user`.
// If the current user exists you can assign the user's token in
// the connection for use in the layout.
//
// In your "lib/web/router.ex":
//
//     pipeline :browser do
//       ...
//       plug MyAuth
//       plug :put_user_token
//     end
//
//     defp put_user_token(conn, _) do
//       if current_user = conn.assigns[:current_user] do
//         token = Phoenix.Token.sign(conn, "user socket", current_user.id)
//         assign(conn, :user_token, token)
//       else
//         conn
//       end
//     end
//
// Now you need to pass this token to JavaScript. You can do so
// inside a script tag in "lib/web/templates/layout/app.html.eex":
//
//     <script>window.userToken = "<%= assigns[:user_token] %>";</script>
//
// You will need to verify the user token in the "connect/3" function
// in "lib/web/channels/user_socket.ex":
//
//     def connect(%{"token" => token}, socket, _connect_info) do
//       # max_age: 1209600 is equivalent to two weeks in seconds
//       case Phoenix.Token.verify(socket, "user socket", token, max_age: 1209600) do
//         {:ok, user_id} ->
//           {:ok, assign(socket, :user, user_id)}
//         {:error, reason} ->
//           :error
//       end
//     end
//
// Finally, connect to the socket:
socket.connect()
let sprites = []
// Now that you are connected, you can join channels with a topic:
let channel = socket.channel("room:lobby", {})
channel.join()
  .receive("ok", resp => {
    console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

let client_id = null;
channel.on("update", payload => {
  client_id = payload.sprite
  let client_status = payload.data
  if(sprites.hasOwnProperty(client_id)){
   update_sprite(client_id, client_status)
  }
  else{
    console.log("New ")

    if(PIXI.utils.TextureCache['images/cat.png'] == undefined){
    PIXI.loader
    .add("images/cat.png")
    .load(create_first_sprite);
    }
   sprites[client_id] =  create_sprite(client_id)
  }
})

function create_first_sprite(){
   sprites[client_id] =  create_sprite(client_id)
}

function update_sprite(sprite, new_status){
  sprites[sprite].vx = 2
  sprites[sprite].vy = 2
  sprites[sprite].x += new_status.velx
  sprites[sprite].y += new_status.vely
}

channel.push("new_msg", {body: "123"} )

export default socket

document.addEventListener("keyup", function(event) {
	const down = true
	const {key} = event
	switch (key) {
		case "ArrowRight":
			channel.push("stop", "right")
			break;
		case "ArrowLeft":
			channel.push("stop", "left")
			break;
		case "ArrowUp":
			channel.push("stop", "up")
			break;
		case "ArrowDown":
			channel.push("stop", "down")
			break;
	}
})

document.addEventListener("keydown", function(event) {
  console.log(event);
	const down = true
	const {key} = event
	switch (key) {
		case "ArrowRight":
			channel.push("move", "right")
			break;
		case "ArrowLeft":
			channel.push("move", "left")
			break;
		case "ArrowUp":
			channel.push("move", "up")
			break;
		case "ArrowDown":
			channel.push("move", "down")
			break;
	}
})



const log = console.log;

//Aliases
let Application = PIXI.Application,
    loader = PIXI.loader,
    resources = PIXI.loader.resources,
    Sprite = PIXI.Sprite;

//Create a Pixi Application
let app = new Application({
    width: 800,
    height: 600,
    antialias: true,
    transparent: false,
    resolution: 1
  }
);

//Add the canvas that Pixi automatically created for you to the HTML document
document.body.appendChild(app.view);
//Define any variables that are used in more than one function

  function setup() {
    let cat;
    //Create the `cat` sprite
    cat = new Sprite(resources["images/cat.png"].texture);
    cat.y = 0;
    app.stage.addChild(cat);
    return cat
  }

function create_sprite(client_id){
  return setup()
}





