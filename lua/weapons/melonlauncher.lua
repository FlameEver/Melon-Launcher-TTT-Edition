AddCSLuaFile()

--[[ Weapon Info ]]--

SWEP.PrintName = "Janik ist Tilted"
SWEP.Author = "FlameEver"

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false

SWEP.Slot = 6
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.HoldType = "rpg"
SWEP.ViewModelFlip	= false
SWEP.ViewModelFOV	= 55
SWEP.Weight = 5

SWEP.ViewModel = "models/weapons/v_rpg.mdl"
SWEP.WorldModel = "models/weapons/w_rocket_launcher.mdl"

SWEP.Base = "weapon_tttbase"
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Primary.Recoil = 1.5 

SWEP.Primary.Damage = 78
SWEP.Primary.ClipSize = 1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.ClipMax = 1

local ShootSound = Sound("weapons/grenade_launcher1.wav")

function SWEP:Initialize()
	self:SetWeaponHoldType( self.HoldType )
end

--[[ TTT Information ]]--

SWEP.EquipMenuData = {
	type = "item_weapon",
	desc = [[
	
	1 shot explosive melon launcher to destroy the 
	innocents.
	
	]]
}

SWEP.Icon = "melon/ttt_icon.png"
SWEP.Kind = WEAPON_EQUIP2
SWEP.CanBuy = { ROLE_TRAITOR }
SWEP.LimitedStock = true
if ( GAMEMODE.Name == "Trouble in Terrorist Town" ) then
	SWEP.Slot = 7
end
	
function SWEP:IsEquipment() return false end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return false end
	self:TakePrimaryAmmo( 1 )
	self.Weapon:SetNextPrimaryFire( CurTime() + 0 )
	
	if (CLIENT) then return end
	self:EmitSound(ShootSound)
	local ang = self.Owner:EyeAngles() 
	local melon = ents.Create( "ent_explosive_melon" )
	if ( IsValid( melon ) ) then
		melon:SetPos( self.Owner:GetShootPos() + ang:Forward() * 50 + ang:Right() * 1 - ang:Up() * 1 )
		melon:SetAngles( ang )
		melon:SetOwner( self.Owner )
		melon:Spawn()
		melon:Activate()
	else
		self:EmitSound("Weapon_AR2.Empty")
	end
end
 
function SWEP:SecondaryAttack()
	-- Nothing will happen
end




