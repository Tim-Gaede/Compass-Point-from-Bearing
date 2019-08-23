#-------------------------------------------------------------------------------
# Returns the compass point from a bearing given in degrees
# Can use the 4-point, 8-point, 16-point, or 32-point set
# NOTE: "North by Northwest" is a movie, not a compass point.
function compassPt(bearing°::Number, num_chars::Int)

    if num_chars < 1  ||  num_chars > 4
        throw("num_chars must be between 1 and 4 inclusively.")
    end

    # Take care of bearings greater than 360° or less than 0°...................
    b = bearing° % 360
    if b < 0;    b += 360; end
    #...........................................................................



    points1 = ['N', 'E', 'S', 'W']

    points2 = ["N ", "NE", "E ", "SE", "S ", "SW", "W ", "NW"]

    points3 = [" N ", "NNE", "NE ", "ENE", " E ", "ESE", "SE ", "SSE",
               " S ", "SSW", "SW ", "WSW", " W ", "WNW", "NW ", "NNW"]

    points4 = [" N  ", "NbE ", "NNE ", "NEbN", " NE ", "NEbE", "ENE ", "EbN ",
               " E  ", "EbS ", "ESE ", "SEbE", " SE ", "SEbS", "SSE ", "SbE ",
               " S  ", "SbW ", "SSW ", "SWbS", " SW ", "SWbW", "WSW ", "WbS ",
               " W  ", "WbN ", "WNW ", "NWbW", " NW ", "NWbN", "NNW ", "NbW "]

    points = [points1, points2, points3, points4]

    point_span° = 360 / 2^(num_chars + 1)

    if b ≥ 360 - point_span° / 2  ||  b < point_span° / 2
        index = 1
    else
        index = convert(Int64, floor((bearing° / point_span°) + 1.5))
    end


    points[num_chars][index]
end
#-------------------------------------------------------------------------------



using Formatting

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function main()
    print("\n", "─"^32, "\n")
    for b = 0 : 360/32 : (31/32)*360
        print(lpad(format(b, precision=2), 6), "° is")
        for n = 1 : 4
            print("   ", compassPt(b, n))
        end
        print("\n", "─"^32, "\n")
    end
end
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
main()
