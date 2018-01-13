
/* NOTE this doesn't work because I can't get ios bytecode compilation working */

/* let writeall = (socket, s) => Unix.send(socket, s, 0, String.length(s), []);

let connectToHotServer = filePath => {

      let socket = Unix.socket(Unix.PF_INET, Unix.SOCK_STREAM, 0);
      Unix.connect(socket, Unix.ADDR_INET(Unix.inet_addr_of_string([%env "LOCAL_IP"]), 8090)) ;

      writeall(socket, "ios:" ++ filePath ++ "\n") |> ignore;

      let buffer = Bytes.create(20);
      let rec loop = (at) => {
        Unix.recv(socket, buffer, at, 1) |> ignore;
        if (Bytes.get(buffer, at) == ':') {
          Bytes.sub_string(buffer, 0, at) |> int_of_string
        } else {
          loop(at + 1)
        }
      };

      let size = loop(0);
      let buffer = Bytes.create(size);

      let rec loop = (gotten) => switch (Unix.recv(socket, buffer, gotten, size - gotten, [])) {
        | 0 => ()
        | r => loop(gotten + r)
        };

      loop(0);

};

let first = ref(true);
let checkRebuild = (filePath) => {
  if (first^) {
    first := false;

    Callback.register("reasonglHotReloaded", (cmaFile: string) => {
      print_endline("Hot Reloading!!!!");
      try {
        Dynlink.loadfile(cmaFile);
      } {
        | err => {
          print_endline("Failed loading: " ++ Printexc.to_string(err));
        }
      }
    });
    Callback.register("reasonglMain", context => {

      connectToHotServer(filePath);


      /* Bindings.startHotReloading(~context, ~host=[%env "LOCAL_IP"], ~baseFile=filePath); */
    });
  }
}; */
let checkRebuild = (filePath) => {
  false
        /* Dynlink.loadfile("./awesome"); */
};