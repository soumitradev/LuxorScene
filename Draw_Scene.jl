# Code was originally written in the Jupyter Notebook, so it is recommended to run this script from there instead.
# Some code may not work in console since displaying output images is not supported in console.

using Luxor

function generate_tree(treex, treey, size, hue, snow = false)
#     Set color and opacity
    setopacity(1)
    sethue(hue)
#     Decide number of triangles to draw for tree depending on size
    for i in 1:round(size/4, digits = 0)+ 3
#         Decide position of each triangle
        pointa = Point(treex, treey + (size+1)*i)
#         Draw triangle
        ngonside(pointa, size*i, 3, pi/6, :fill)
    end
#     If tree is snow-covered, then render the two top triangles as white.
#     This is placed after the loop since other triangles draw over the first 2 in the loop, and make it look weird.
    if (snow)
        setopacity(1)
        sethue("snow")
        ngonside(Point(treex, treey + (size+1)*1), size, 3, pi/6, :fill)
        ngonside(Point(treex, treey + (size+1)*2), size*2, 3, pi/6, :fill)
    end
end

function generate_house(x, y)
    
#     Setup
    setopacity(1)
    
#     Draw polygon on the left (left side of house, below the snowy roof)
    sethue(0.7451, 0.5882, 0.549)
    poly([Point(x-157, y+60), Point(x-86, y+50), Point(x-87, y+99), Point(x-157, y+103)], close = true, :fill)
    sethue(0.6588, 0.4745, 0.4431)
    poly([Point(x-157, y+60), Point(x-86, y+50), Point(x-87, y+99), Point(x-157, y+103)], close = true, :stroke)
    
#     Draw the front of the house (Pentagon shaped face)
    sethue(0.7451, 0.5882, 0.549)
    poly([Point(x-86, y+50), Point(x-87, y+99), Point(x+44, y+103), Point(x+42, y+53), Point(x-11, y-41)], close = true, :fill)
    sethue(0.6588, 0.4745, 0.4431)
    poly([Point(x-86, y+50), Point(x-87, y+99), Point(x+44, y+103), Point(x+42, y+53), Point(x-11, y-41)], close = true, :stroke)
    
#     Draw the snowy roof
    sethue("snow")
    poly([Point(x-157, y+60), Point(x-86, y+50), Point(x-11, y-41), Point(x-116, y+11)], close = true, :fill)
    sethue("snow2")
    poly([Point(x-157, y+60), Point(x-86, y+50), Point(x-11, y-41), Point(x-116, y+11)], close = true, :stroke)
    
#     Draw the chimney
    sethue(0.7451, 0.5882, 0.549)
    poly([Point(x-114, y+20), Point(x-90, y+20), Point(x-89, y-45), Point(x-106, y-40)], close = true, :fill)
    sethue(0.6588, 0.4745, 0.4431)
    poly([Point(x-114, y+20), Point(x-90, y+20), Point(x-89, y-45), Point(x-106, y-40)], close = true, :stroke)
    
#     Generate the bezier for the smoke and draw it
    sethue("whitesmoke")
    setline(20)
    setopacity(0.2)
    drawbezierpath(makebezierpath([Point(x-100, y-45), Point(x-80, y-50), Point(x-130, y-80), Point(x-30, y-132), Point(x-100, y-200)]), close = false, :stroke)
    
#     Reset to original stroke properties after drawing smoke
    setopacity(1)
    setline(1)
    
#     Draw Windows
#     Draw left most window
    sethue("gold")
    poly([Point(x-150, y+87), Point(x-130, y+85), Point(x-131, y+61), Point(x-150, y+64)], close = true, :fill)
    sethue("tan4")
    poly([Point(x-150, y+87), Point(x-130, y+85), Point(x-131, y+61), Point(x-150, y+64)], close = true, :stroke)
    line(Point(x-140, y+85), Point(x-141, y+63), :stroke)
    line(Point(x-130.5, y+73), Point(x-150, y+76), :stroke)
    
#     Draw the window to the immediate right of the leftmost window
    sethue("gold")
    poly([Point(x-117, y+82), Point(x-97, y+80), Point(x-97, y+56), Point(x-117, y+59)], close = true, :fill)
    sethue("tan4")
    poly([Point(x-117, y+82), Point(x-97, y+80), Point(x-97, y+56), Point(x-117, y+59)], close = true, :stroke)
    line(Point(x-107, y+80), Point(x-108, y+57), :stroke)
    line(Point(x-117, y+71), Point(x-97, y+69), :stroke)
    
#     Draw the window next to the door
    sethue("gold")
    poly([Point(x, y+90), Point(x+30, y+90), Point(x+30, y+55), Point(x, y+53)], close = true, :fill)
    sethue("tan4")
    poly([Point(x, y+90), Point(x+30, y+90), Point(x+30, y+55), Point(x, y+53)], close = true, :stroke)
    line(Point(x, y+72), Point(x+30, y+73), :stroke)
    line(Point(x+15, y+54), Point(x+15, y+90), :stroke)
    
#     Draw the circular window above the door
    sethue("gold")
    circle(x-15, y+10, 12, :fill)
    sethue("tan4")
    circle(x-15, y+10, 12, :stroke)
    line(Point(x-27, y+10), Point(x-3, y+10), :stroke)
    line(Point(x-15, y+22), Point(x-15, y-2), :stroke)
    
#     Draw the door    
    setopacity(0.3)
    sethue("tan3")
    poly([Point(x-61, y+100), Point(x-30, y+100.8),  Point(x-29, y+48), Point(x-60, y+48)], close = true, :fill)
    setopacity(0.4)
    sethue("tan4")
    poly([Point(x-61, y+100), Point(x-30, y+100.8),  Point(x-29, y+48), Point(x-60, y+48)], close = true, :stroke)
end

# Setup drawing
Drawing(600, 314, "Scene.png")
# Set current point to origin
origin()

# Set up the sky
nightsky = blend(Point(0, -300), Point(0, 230), "midnightblue", "steelblue2")
setblend(nightsky)
box(O, 600, 314, :fill)

# Draw the stars
sethue("grey100")
circle(-136, -78, 1, :fill)
circle(-26, -88, 1, :fill)
circle(120, -117, 1, :fill)

# Draw moon
sethue("white")
setopacity(0.8)
circle(200, -100, 20, :fill)

# Generate size noise for trees
size = noise.(range(0, 5, length=10), detail = 10, persistence = 0)

# Generate new noise for ground on which house lies
yfore = noise.(range(4, 8, length=10), detail = 10, persistence = 0)

# Process ground noise to an array of points, and get array of lowest y-coordinate of noise (we draw the rect using this)
y_fore = .-(20, 70*yfore)
# Generate the Points, and put them in an array (WARNING: LOTS of Arbitrary constants)
gpointa = Point.(-370 .+ 70*collect(1:10), y_fore[collect(1:10)] .+ (yfore[collect(1:10)]*4 .+ 12)*8.2)
# Get array of y-coordinates of noise
abcd = map(x -> x.y , gpointa)

# Process tree size noise to an array of points, and get array of lowest y-coordinate of noise (we draw the ground using this)
y_pos = .-(-10, 50*size)
# Generate the Points, and put them in an array (WARNING: LOTS of arbitrary constants)
gpoint = Point.(-330 .+ 60*collect(1:10), y_pos[collect(1:10)] .+ (size[collect(1:10)]*4 .+ 10)*8.2)
# Get array of y-coordinates of noise
abc = map(x -> x.y , gpoint)

# Add drawing endpoints to make Bezier cover a large chunk of ground without needing the rect (Background terrain)
push!(gpoint, Point(400, gpoint[end].y), Point(301, 158), Point(-301, 158), Point(-350, gpoint[1].y))
# Add drawing endpoints to make Bezier cover a large chunk of ground without needing the rect (House terrain)
push!(gpointa, Point(400, gpointa[end].y), Point(301, 158), Point(-301, 158), Point(-350, gpointa[1].y))

# Draw trees starting from edge of the screen to the other edge, while using size and position noise.
for treenum in 1:10
    x = -330 + 60*treenum
    generate_tree(x, -10 - 50*size[treenum], size[treenum]*4 + 10, "dodgerblue4")
end

# Create rect to cover up rest of terrain that Bezier didn't cover by using 
# lowest point of bezier (minimum of noise y-coordinate), But using maximum since values are negative. (Background)
sethue("lavenderblush2")
box(Point(-301, maximum(abc)), Point(301, 158), :fill, vertices = false)
poly(polyfit(gpoint), :fill)

# Create rect to cover up rest of terrain that Bezier didn't cover by using 
# lowest point of bezier (minimum of noise y-coordinate), But using maximum since values are negative. (House Ground)
sethue("lavenderblush1")
setopacity(1)
box(Point(-301, maximum(abcd)), Point(301, 158), :fill, vertices = false)
poly(polyfit(gpointa), :fill)

# Draw the house with slightly adjusted coordinates
generate_house(50, -10)

# Draw snow-covered trees next to house without using noise
generate_tree(250, 20, 11, "forestgreen", true)
generate_tree(210, 70, 9, "forestgreen", true)
generate_tree(150, 30, 12, "forestgreen", true)

# Draw terrain closest to viewer using a large triangle partially offscreen
sethue("snow")
setopacity(0.9)
drawbezierpath(makebezierpath([Point(-400, 100), Point(200, 200), Point(-200, 350)]), :fill)

# Draw our final tree in foreground
generate_tree(-250, -40, 16, "forestgreen", true)


finish()
preview()
