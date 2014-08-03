return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 84,
  height = 63,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {
    {
      name = "powerup",
      firstgid = 1,
      tilewidth = 32,
      tileheight = 32,
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
          image = "images/powerup-spawn.png",
          width = 32,
          height = 32
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
          x = 50,
          y = 1186,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 68, y = 64 },
            { x = 42, y = 132 },
            { x = 49, y = 198 },
            { x = 86, y = 254 },
            { x = 160, y = 264 },
            { x = 290, y = 334 },
            { x = 534, y = 480 },
            { x = 688, y = 548 },
            { x = 924, y = 626 },
            { x = 1252, y = 676 },
            { x = 1366, y = 666 },
            { x = 1524, y = 684 },
            { x = 1886, y = 702 },
            { x = 2093.88, y = 696.875 },
            { x = 2229.75, y = 655.75 },
            { x = 2369.5, y = 591.5 },
            { x = 2573, y = 375 },
            { x = 2572, y = 300 },
            { x = 2524.75, y = 98.25 },
            { x = 2621.5, y = 86.5 },
            { x = 2615, y = 779 },
            { x = 1884, y = 784 },
            { x = -26, y = 778 },
            { x = -38, y = 24 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 324,
          y = 1340,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 114, y = -46 },
            { x = 274, y = -60 },
            { x = 394, y = -92 },
            { x = 688, y = -80 },
            { x = 756, y = -60 },
            { x = 868, y = -66 },
            { x = 960, y = -104 },
            { x = 1120, y = -120 },
            { x = 1248, y = -152 },
            { x = 1532, y = -138 },
            { x = 1592, y = -116 },
            { x = 1664, y = -128 },
            { x = 1693, y = -118.5 },
            { x = 1702, y = -93 },
            { x = 1580, y = -88 },
            { x = 1282, y = -118 },
            { x = 1128, y = -74 },
            { x = 972, y = -68 },
            { x = 864, y = -26 },
            { x = 720, y = -26 },
            { x = 448, y = -62 },
            { x = 290, y = -4 },
            { x = 134, y = -8 },
            { x = 42, y = 14 }
          },
          properties = {}
        }
      }
    },
    {
      type = "objectgroup",
      name = "PowerUps",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {
        {
          name = "",
          type = "",
          shape = "rectangle",
          x = 2486,
          y = 1240,
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
          x = 234,
          y = 1268,
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
          x = 968,
          y = 1234,
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
          x = 2162,
          y = 1182,
          width = 0,
          height = 0,
          rotation = 0,
          gid = 1,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
