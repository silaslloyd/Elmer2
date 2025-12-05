-- #############################################################
--  A list of usefull constants for ice-sheet simulations
--   
--   - Unit System =
--      -- m
--      -- a
--      -- MPa
-- #############################################################



exp=math.exp

-- ## constants declaration
yearinsec=365.25*24.0*3600.0
Pa2MPa=1.0E-06
rhoi=917.0
gravity = -9.81*yearinsec^2.0
A1 = 1.258E+13         --- MPa^(-3) a^(-1)
A2 = 6.046E+28         --- MPa^(-3) a^(-1)
Q1 = 60.0E3 
Q2 = 139.0E3

-- # utility functions --

function max(a,b)
  if (a > b) then
    return a
  else
    return b
  end  
end    
function min(a,b)
  if (a < b) then
    return a
  else
    return b
  end  
end  

function IfThenElse(condition,t,f) 
   if condition then return t else return f end 
end 

function acc(x,y)
    a_max = 0.5
    Sb = 1E-05
    R_el = 4.5E05
    r = (x*x + y*y)^0.5
    a = min(a_max, Sb*(R_el-r))
    return a
end 

function surfaceT(x, y)
    Tmin = 238.15
    ST = 1.67E-05
    r = (x*x + y*y)^0.5
    T_surf = Tmin + ST*r
    return T_surf
end

function Hinit(x,y)
    h0=2000
    dh=1900
    r0=4E05
    r = (x*x + y*y)^0.5
    H = h0-dh*(r^2 / r0^2)
    return H
end
    
    
-- ## thermal properties
function conductivity(Tin)
 T = Tin
 if (T > 273.15) then
   T = 273.15
 end 
 k=9.828*exp(-5.7E-03*T)
 return k
end

-- ## heat capacity
function capacity(Tin)
  T = Tin
  if (T > 273.15) then
    T = 273.15
  end 
  c=146.3+(7.253*T)
  return c
end

-- ## relative temperature
function reltemp(T)
  Th= T - 273.15
  return Th
end

-- friction loads
function frictionloads(lx,ly,lz,vx,vy,vz)
  cx = max(-lx*vx,0)
  cy = max(-ly*vy,0)
  cz = max(-ly*vy,0)
  return cx + cy + cz
end  