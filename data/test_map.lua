return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 100,
  height = 100,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {
    {
      name = "runes",
      firstgid = 1,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      image = "images/runes.png",
      imagewidth = 512,
      imageheight = 512,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      tiles = {}
    },
    {
      name = "guys",
      firstgid = 17,
      tilewidth = 128,
      tileheight = 128,
      spacing = 0,
      margin = 0,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      tiles = {
        {
          id = 0,
          image = "images/enemy.png",
          width = 32,
          height = 32
        },
        {
          id = 1,
          image = "images/ground.png",
          width = 16,
          height = 16
        },
        {
          id = 2,
          image = "images/john-the-placeholder.png",
          width = 128,
          height = 128
        },
        {
          id = 3,
          image = "images/player.png",
          width = 32,
          height = 32
        }
      }
    }
  },
  layers = {
    {
      type = "objectgroup",
      name = "map_images",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 20.9483,
          y = 192.592,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 1,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 499.06,
          y = 477.013,
          width = 0,
          height = 0,
          rotation = -65.0701,
          gid = 2,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 106,
          y = 326,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 6,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 390,
          y = 287,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 5,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 282,
          y = 278,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 17,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 244,
          y = 433,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 19,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 246.853,
          y = 213.598,
          width = 0,
          height = 0,
          rotation = -42.0949,
          gid = 17,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 324.38,
          y = 195.566,
          width = 0,
          height = 0,
          rotation = 43.5679,
          gid = 17,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 282,
          y = 229,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 20,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 237,
          y = 260,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 20,
          visible = true,
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 331,
          y = 263,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 20,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
