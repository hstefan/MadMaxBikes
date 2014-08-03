return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 84,
  height = 29,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {
    {
      name = "things",
      firstgid = 1,
      tilewidth = 64,
      tileheight = 64,
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
          image = "bg_placeholder.png",
          width = 64,
          height = 64
        }
      }
    }
  },
  layers = {
    {
      type = "imagelayer",
      name = "Image Layer 1",
      visible = true,
      opacity = 1,
      image = "backgrounds/bg4.png",
      properties = {}
    },
    {
      type = "objectgroup",
      name = "Objects",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
    {
      type = "objectgroup",
      name = "Physics",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 198,
          y = 26,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 38, y = 232 },
            { x = 128, y = 354 },
            { x = 302, y = 468 },
            { x = 502, y = 516 },
            { x = 730, y = 582 },
            { x = 992, y = 612 },
            { x = 1254, y = 640 },
            { x = 1558, y = 632 },
            { x = 1718, y = 634 },
            { x = 1734, y = 764 },
            { x = -34, y = 754 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 2642,
          y = 420,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -378, y = 172 },
            { x = -740, y = 240 },
            { x = -766, y = 400 },
            { x = 3, y = 100 }
          },
          properties = {}
        }
      }
    }
  }
}
