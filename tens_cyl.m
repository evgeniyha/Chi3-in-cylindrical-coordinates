clear all
% Define symbolic variables
syms phi;
% Define transformation matrix R
R = [cos(phi), sin(phi), 0; -sin(phi), cos(phi), 0; 0, 0, 1];

% Initialize fourth-rank tensor chi with zeros
chi3 = sym(zeros(3,3,3,3));

% Assign arbitrary values for components (cubic or isotropic tensor)
chi4_value1 = 8; % For xxxx = yyyy = zzzz
chi4_value2 = 4; % For yyyz = zzxy = etc.
chi4_value3 = 4; % For yzyz = zjzy = etc.
chi4_value4 = 4; % For yzzy = zyyz = etc.

% Assign values to tensor components based on the provided relationships
% xxxx = yyyy = zzzz
chi3(1,1,1,1) = chi4_value1;
chi3(2,2,2,2) = chi4_value1;
chi3(3,3,3,3) = chi4_value1;

% yyzz = zzyy = zzxx = xxzz = xxyy = yyxx
chi3(2,2,3,3) = chi4_value2;
chi3(3,3,2,2) = chi4_value2;
chi3(3,3,1,1) = chi4_value2;
chi3(1,1,3,3) = chi4_value2;
chi3(1,1,2,2) = chi4_value2;
chi3(2,2,1,1) = chi4_value2;

% yzyz = zyzy = zxzx = xzxz = xyxy = yxyx
chi3(2,3,2,3) = chi4_value3;
chi3(3,2,3,2) = chi4_value3;
chi3(3,1,3,1) = chi4_value3;
chi3(1,3,1,3) = chi4_value3;
chi3(1,2,1,2) = chi4_value3;
chi3(2,1,2,1) = chi4_value3;

% yzzy = zyyz = zxxz = xzzx = xyxy = yxxy
chi3(2,3,3,2) = chi4_value4;
chi3(3,2,2,3) = chi4_value4;
chi3(3,1,1,3) = chi4_value4;
chi3(1,3,3,1) = chi4_value4;
chi3(1,2,2,1) = chi4_value4;
chi3(2,1,1,2) = chi4_value4;

% Assuming the rest of the components are set to zero
% Transform chi to cylindrical coordinates (rho, phi, z)
chi3_cyl = sym(zeros(3,3,3,3));
for n1 = 1:3
    for n2 = 1:3
        for n3 = 1:3
            for n4 = 1:3
                sum = sym(0);
                for i1 = 1:3
                    for i2 = 1:3
                        for i3 = 1:3
                            for i4 = 1:3
                                sum = sum + R(n1,i1)*R(n2,i2)*R(n3,i3)*R(n4,i4)*chi3(i1,i2,i3,i4);
                            end
                        end
                    end
                end
                chi3_cyl(n1,n2,n3,n4) = simplify(sum);
            end
        end
    end
end

% Display the transformed tensor
disp(chi3_cyl);
