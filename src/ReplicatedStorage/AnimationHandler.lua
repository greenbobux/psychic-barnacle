-- Animation Handler
-- green/devtychi
-- January 21, 2021



local AnimationHandler = {}

function AnimationHandler:new(animator: userdata, optional_data: table)
    local Animator = {Animations = {}; PlayingAnimations = {}}
    Animator.Controller = animator
    function Animator:PlayAnimation(name: string)
        if Animator.Animations[name] then
            return Animator.Animations[name]:Play()
        else
            warn("Animation not found: ".. name)
        end

    end
    function Animator:EndAnimation(AnimationName)
        local var = self.PlayingAnimations[AnimationName]
        if var then

            var:Stop()
            self.PlayingAnimations[AnimationName] = nil
        end

    end
    function Animator:LoadAnimation(AnimationToLoad: Animation, ExtraData: table)
        local index = AnimationToLoad.Name or ExtraData.Name
        local Animation = self.Animations[index]

        if not Animation then
            
            self.Animations[index] = self.Controller:LoadAnimation(AnimationToLoad)
        end
        Animation = self.Animations[index]
        if ExtraData.PlayAnimations then
            if index then

                local isplaying = self.PlayingAnimations [index] 
                
                if isplaying then isplaying:Stop() end
            end
           

            self.PlayingAnimations[index] = Animation:Play()
            
        end

        return Animation
    end
    return Animator
end
return AnimationHandler