--- @sync entry

local function entry(st)
    if st.old then
        Tab.layout, st.old = st.old, nil
    else
        st.old = Tab.layout
        ---@diagnostic disable-next-line: duplicate-set-field
        Tab.layout = function(jobs)
            local all = MANAGER.ratio.parent + MANAGER.ratio.current
            jobs._chunks = ui.Layout()
                :direction(ui.Layout.HORIZONTAL)
                :constraints({
                    ui.Constraint.Ratio(MANAGER.ratio.parent, all),
                    ui.Constraint.Ratio(MANAGER.ratio.current, all),
                    ui.Constraint.Length(1),
                })
                :split(jobs._area)
        end
    end
    ya.app_emit("resize", {})
end

local function enabled(st) return st.old ~= nil end

return { entry = entry, enabled = enabled }
