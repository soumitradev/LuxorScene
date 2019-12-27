# Drawing a scene using Luxor.jl

This script draws a scene using the package [Luxor.jl](https://github.com/JuliaGraphics/Luxor.jl). I have drawn a snowy landscape that looks simple at first, but uses complex features of Luxor.jl to add attention to detail.

![](https://i.imgur.com/82ypriS.png)

**Disclaimer:** I have **_very_** bad choice of color, and this shows especially in the part where we render the house. Any help relating to fix that eyesore of a house is always welcome. I'm sorry you have to see this house for now XD.

## Background
To describe my image, I have used layers to add depth to the scene. In the background I have used a gradient color — or as Luxor calls it, a `blend` — for the sky, and have used circles for the moon and stars. Still in the background, but not quite the foreground, I have drawn coniferous trees by defining a function `generate_trees()` that takes in the following parameters listed in order:
- **`treex`**: Specifies the x-coordinate of the topmost part of the tree
- **`treey`**: Specifies the y-coordinate of the topmost part of the tree
- **`size`**: Specifies the size of the tree (arbitrary number, not pixels)
- **`hue`**: Color or `hue` of the tree
- **`snow`**: Specifies if the tree has snow on top (default = false)

Then, I used Perlin noise to generate a smooth randomness between the sizes of the trees. [This blogpost](https://cormullion.github.io/blog/2018/10/16/noise.html) by Cormullion really helped. I used the same Perlin Noise to generate a `Bezier Curve` for the topmost part of the snow-covered ground for the trees.
I covered the rest of the ground using a `rect` or `box`.

## Foreground
In the foreground, I again used Perlin Noise to generate the terrain on which the house lies, generated a `Bezier Curve`, and covered the rest of the ground using a `rect` or a `box`.

For the house, I again defined a function purely for aesthetical and readability purposes since there was too much code in one cell.

The function `generate_house()` takes in `x` and `y` signifying the x and y coordinates of the house respectively.

I used **lots** of polygons to make the house, and made another one above the previous one for a slightly darker edge stroke to each polygon.

For the house walls, I used a custom color since the colors in the palette were not looking all that great on the house. Since the house is done so poorly, I feel a pressing need to specify that the roof of the house is white due to the accumulation of snow over it.

For the windows and chimney, I used polygons (again), but for the window frames, I used lines. I used a **t h i c c** bezier curve for the smoke, and reduced its opacity. In my opinion, the smoke _could_ be made using a brush made up of beziers, but it seemed like to much work for very little benefit.

Again, I added some snow-covered trees in the foreground (which look _very_ "South Park" by the way), and added another layer of snow-covered land using a bezier curve made from a large triangle which is partially offscreen.

Finally, after ~9 hours of continuous testing, coding, looking through docs, drawing beziers, and punching numbers on my calculator, this drawing was done.

Comments are added througout the code explaining what each block of code does. I have not added markdown over every cell since most of the magic happens in one cell, while the others are just there for good organisation.

## References & Thanks
HUGE thanks to docs and package of course, it is amazing how much work has gone into them and how extensive both the docs and the package are.
Repo of Package: https://github.com/JuliaGraphics/Luxor.jl

Thanks to the [Blogpost](https://cormullion.github.io/blog/2018/10/16/noise.html) by [Cormullion](https://github.com/cormullion).