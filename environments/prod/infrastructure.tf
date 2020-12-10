variable shardes {
 description = "Shardes list"
 type = list(string)
 default = ["shard1", "shard2"]
}

variable nodes {
 description = "Nodes list"
 type = list(object({
  shard   = string
  name    = string
  account = string
 }))
 default = [
  {
   shard   = "shard1"
   name    = "node1a"
   account = "inita"
  },
  {
   shard   = "shard1"
   name    = "node1b"
   account = "initb"
  },
  {
   shard   = "shard1"
   name    = "node1c"
   account = "initc"
  },
  {
   shard   = "shard1"
   name    = "node1d"
   account = "initd"
  },

  {
   shard   = "shard2"
   name    = "node2a"
   account = "inita"
  },
  {
   shard   = "shard2"
   name    = "node2b"
   account = "initb"
  },
  {
   shard   = "shard2"
   name    = "node2c"
   account = "initc"
  },
  {
   shard   = "shard2"
   name    = "node2d"
   account = "initd"
  },
 ]
}
