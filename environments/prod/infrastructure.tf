variable shardes {
 description = "Shardes map"
 default = {
   "shard1" = "node1a, node1b, node1c, node1d"
   "shard2" = "node2a, node2b, node2c, node2d"
  }
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
