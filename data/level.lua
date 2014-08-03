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
    },
    {
      name = "terrain",
      firstgid = 2,
      tilewidth = 1220,
      tileheight = 1087,
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
          image = "mid-platform.png",
          width = 1220,
          height = 353
        },
        {
          id = 1,
          image = "mid-tower.png",
          width = 1003,
          height = 1087
        }
      }
    }
  },
  layers = {
    {
      type = "objectgroup",
      name = "BgObjects",
      visible = true,
      opacity = 1,
      properties = {},
      objects = {}
    },
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
            { x = 1196, y = 636 },
            { x = 1378, y = 594 },
            { x = 1588, y = 674 },
            { x = 1890, y = 662 },
            { x = 2095.88, y = 668.875 },
            { x = 2229.75, y = 655.75 },
            { x = 2369.5, y = 591.5 },
            { x = 2573, y = 375 },
            { x = 2572, y = 300 },
            { x = 2532.75, y = 72.25 },
            { x = 2569.12, y = 66.375 },
            { x = 2585.31, y = -593.562 },
            { x = 2619.41, y = -628.531 },
            { x = 2621.5, y = 86.5 },
            { x = 2615, y = 779 },
            { x = 1884, y = 784 },
            { x = -26, y = 778 },
            { x = -38, y = -624 },
            { x = -9, y = -558 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 322,
          y = 1312,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = -80, y = -2 },
            { x = 18, y = -68 },
            { x = 164, y = -102 },
            { x = 296, y = -156 },
            { x = 584, y = -182 },
            { x = 652, y = -170 },
            { x = 734, y = -176 },
            { x = 814, y = -200 },
            { x = 759.25, y = -148.5 },
            { x = 330.5, y = -121 },
            { x = 191, y = -60 },
            { x = -16, y = -4 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 1122,
          y = 1092,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 34, y = -16 },
            { x = 66, y = -74 },
            { x = 86, y = -136 },
            { x = 88, y = -214 },
            { x = 68, y = -286 },
            { x = 16, y = -378 },
            { x = 2, y = -428 },
            { x = 32, y = -450 },
            { x = 106, y = -306 },
            { x = 130, y = -218 },
            { x = 128, y = -156 },
            { x = 108, y = -86 },
            { x = 70, y = -12 },
            { x = 22, y = 54 },
            { x = -28, y = 46 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 1566,
          y = 1144,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -68, y = -94 },
            { x = -104, y = -212 },
            { x = -94, y = -298 },
            { x = -52, y = -406 },
            { x = 0, y = -500 },
            { x = 22, y = -478 },
            { x = 24, y = -450 },
            { x = -20, y = -362 },
            { x = -48, y = -288 },
            { x = -50, y = -224 },
            { x = -36, y = -142 },
            { x = 4, y = -60 },
            { x = 54, y = -12 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 1596,
          y = 1136,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 6, y = -12 },
            { x = 80, y = 4 },
            { x = 166, y = 16 },
            { x = 210, y = -2 },
            { x = 492, y = 26 },
            { x = 566, y = 56 },
            { x = 624, y = 78 },
            { x = 780, y = 116 },
            { x = 858, y = 182 },
            { x = 816, y = 182 },
            { x = 730, y = 142 },
            { x = 588, y = 116 },
            { x = 454, y = 56 },
            { x = 270, y = 56 },
            { x = 142, y = 46 },
            { x = 22, y = 20 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 986,
          y = 814,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = 8, y = -76 },
            { x = -170, y = -130 },
            { x = -386, y = -180 },
            { x = -562, y = -232 },
            { x = -690, y = -264 },
            { x = -740, y = -298 },
            { x = -916, y = -472 },
            { x = -932, y = -494 },
            { x = -836, y = -606 },
            { x = -750, y = -804 },
            { x = -974, y = -800 },
            { x = -974, y = -352 },
            { x = -802, y = -226 },
            { x = -36, y = -2 }
          },
          properties = {}
        },
        {
          name = "",
          type = "",
          shape = "polygon",
          x = 1740,
          y = 828,
          width = 0,
          height = 0,
          rotation = 0,
          visible = true,
          polygon = {
            { x = 0, y = 0 },
            { x = -8, y = -84 },
            { x = 694, y = -270 },
            { x = 898, y = -466 },
            { x = 898, y = -502 },
            { x = 828, y = -612 },
            { x = 746, y = -812 },
            { x = 940, y = -814 },
            { x = 938, y = -320 },
            { x = 810, y = -234 },
            { x = 660, y = -176 }
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
          x = 2456,
          y = 1096,
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
          x = 206,
          y = 1222,
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
          x = 934,
          y = 616,
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
          x = 1714,
          y = 1582,
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
          x = 1744,
          y = 612,
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
          x = 1168,
          y = 1592,
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
