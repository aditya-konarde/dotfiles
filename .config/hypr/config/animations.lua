-- No desktop motion: disable all animation branches, including inherited fades.
hl.config({
    animations = { enabled = false },
    render = { ctm_animation = 0 },
})
hl.animation({ leaf = "global", enabled = false })
