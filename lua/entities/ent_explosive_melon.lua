AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false

local melon = Material( "models/props_junk/watermelon01.mdl" )

function ENT:Draw()
	self:DrawModel()
	local vel = self:GetVelocity()
	if ( vel:Length() < 0.5 ) then vel = self:GetAngles():Forward() end
	
	vel:Normalize()
	
	local vz = vel:Angle().p

	vel:Rotate( Angle( 0, 90, 0 ) )
	vel.z = 0

	surface.SetDrawColor( color_white )
	
end


 
function ENT:Initialize()
 
	self:SetModel( "models/props_junk/watermelon01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )      
	self:SetMoveType( MOVETYPE_VPHYSICS )   
	self:SetSolid( SOLID_VPHYSICS )         
 
    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
		local velocity = self.Owner:GetAimVector()
		velocity = velocity * 100000
		velocity = velocity + ( VectorRand() * 1 ) 
		phys:ApplyForceCenter( velocity )
	end
end

function ENT:PhysicsCollide( data, physobj )
	local ent = ents.Create( "env_explosion" )
	ent:SetPos( self:GetPos() )
	ent:SetOwner( self:GetOwner() )
	ent:SetPhysicsAttacker( self )
	ent:Spawn()
	ent:SetKeyValue( "iMagnitude", "0" )
	ent:Fire( "Explode", 0, 0 )
	
	util.BlastDamage( self, self:GetOwner(), self:GetPos(), 128, 90 )

	self:Remove()
end
