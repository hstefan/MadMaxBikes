return {
  version = "1.1",
  luaversion = "5.1",
  orientation = "orthogonal",
  width = 84,
  height = 63,
  tilewidth = 32,
  tileheight = 32,
  properties = {},
  tilesets = {},
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
            { x = 92, y = 88 },
            { x = 50, y = 186 },
            { x = 56, y = 240 },
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
        }
      }
    }
  }
}
