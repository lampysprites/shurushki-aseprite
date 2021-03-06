if not app.activeSprite then
    app.alert("Please open a sprite first.")
end

if not app.activeCel then
    app.alert("Please select a cel to be linked.")
end


app.transaction( function()
    local sprite, frame = app.activeSprite, app.activeCel.frameNumber

    for k,layer in ipairs(app.range.layers) do
        -- For some reason, in the script, linking skips empty cels (due to how range works i guess?)
        -- let's create empties where they should go
        for _,frame in ipairs(app.range.frames) do
            if not layer:cel(frame) then
                sprite:newCel(layer, frame)
            end
        end
        
        -- we need to link to the active cel, but the app.command links to the first cel, so  let's copy the image to the first
        local proto = layer:cel(app.range.frames[1])
        local cel = layer:cel(frame)
        proto.image = cel.image
        proto.position = cel.position
        -- ??? not copying cel.color, cel.opacity etc. is it needed ???
    end

    app.command.LinkCels()
end)