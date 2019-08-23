#-------------------------------------------------------------------------------
# Timothy Gaede 2019-08-23
#
# The function returns the compass point from a bearing given in degrees.
# The returned compass point may be from any of the four 
# (4, 8, 16, or 32 point) standards.
# NOTE: "North by Northwest" is a movie, not a compass point.
function compassPt(bearing°::Number, num_chars::Int)

    if num_chars < 1  ||  num_chars > 4
        throw("num_chars must be between 1 and 4 inclusively.")
    end

    # Take care of bearings greater than 360° or less than 0°...................
    b° = bearing° % 360
    if b° < 0;    b° += 360; end
    #...........................................................................



    pts1 = ['N', 'E', 'S', 'W']

    pts2 = ["N ", "NE", "E ", "SE", "S ", "SW", "W ", "NW"]

    pts3 = [" N ", "NNE", "NE ", "ENE", " E ", "ESE", "SE ", "SSE",
            " S ", "SSW", "SW ", "WSW", " W ", "WNW", "NW ", "NNW"]

    pts4 = [" N  ", "NbE ", "NNE ", "NEbN", " NE ", "NEbE", "ENE ", "EbN ",
            " E  ", "EbS ", "ESE ", "SEbE", " SE ", "SEbS", "SSE ", "SbE ",
            " S  ", "SbW ", "SSW ", "SWbS", " SW ", "SWbW", "WSW ", "WbS ",
            " W  ", "WbN ", "WNW ", "NWbW", " NW ", "NWbN", "NNW ", "NbW "]

    pts = [pts1, pts2, pts3, pts4]

    pt_span° = 360 / 2^(num_chars + 1)

    if b° ≥ 360 - pt_span° / 2  ||  b° < pt_span° / 2
        index = 1
    else
        index = convert(Int64, floor((b° / pt_span°) + 1.5))
    end


    pts[num_chars][index]
end
#-------------------------------------------------------------------------------




using Formatting

#═══════════════════════════════════════════════════════════════════════════════
function main()
    print("\n", "─"^32, "\n")
    for b = 0 : 360/32 : (31/32)*360
        print(lpad(format(b, precision=2), 6), "° is")
        for n = 1 : 4
            print("   ", compassPt(b, n))
        end
        print("\n", "─"^32, "\n")
    end

    compassPtTester()
end
#═══════════════════════════════════════════════════════════════════════════════
main()
