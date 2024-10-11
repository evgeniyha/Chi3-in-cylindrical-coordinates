clear 
clc
% Define symbolic variables
syms phi;
% Define transformation matrix R
R = [cos(phi), sin(phi), 0; -sin(phi), cos(phi), 0; 0, 0, 1];

% Initialize fourth-rank tensor chi with zeros
chi3 = sym(zeros(3,3,3,3));

% Assign arbitrary values for components 
chi4_value1 = 1; 
chi4_value2 = 2; 
chi4_value3 = 3; 

% Assign values to tensor components based on the provided relationships
chi3(1,1,1,1) = chi4_value1;
chi3(2,2,2,2) = chi4_value1;
chi3(3,3,3,3) = chi4_value1;

chi3(2,2,3,3) = chi4_value2;
chi3(2,3,3,2) = chi4_value2;
chi3(2,3,2,3) = chi4_value2;
chi3(3,3,1,1) = chi4_value2;
chi3(3,1,1,3) = chi4_value2;
chi3(3,1,3,1) = chi4_value2;
chi3(1,1,2,2) = chi4_value2;
chi3(1,2,2,1) = chi4_value2;
chi3(1,2,1,2) = chi4_value2;

chi3(3,3,2,2) = chi4_value3;
chi3(3,2,3,2) = chi4_value3;
chi3(3,2,2,3) = chi4_value3;
chi3(1,1,3,3) = chi4_value3;
chi3(1,3,1,3) = chi4_value3;
chi3(1,3,3,1) = chi4_value3;
chi3(2,2,1,1) = chi4_value3;
chi3(2,1,2,1) = chi4_value3;
chi3(2,1,1,2) = chi4_value3;

% Assuming the rest of the components are set to zero
% Transform chi to cylindrical coordinates (rho, phi, z)
chi3_cyl = sym(zeros(3,3,3,3));
% for n1 = 1:3
%     for n2 = 1:3
%         for n3 = 1:3
%             for n4 = 1:3
%                 sum = sym(0);
%                 for i1 = 1:3
%                     for i2 = 1:3
%                         for i3 = 1:3
%                             for i4 = 1:3
%                                 sum = sum + R(n1,i1)*R(n2,i2)*R(n3,i3)*R(n4,i4)*chi3(i1,i2,i3,i4);
%                             end
%                         end
%                     end
%                 end
%                 chi3_cyl(n1,n2,n3,n4) = simplify(sum);
%             end
%         end
%     end
% end

for n1 = 1:3
    for n2 = 1:3
        for n3 = 1:3
            for n4 = 1:3

                Rm = reshape(R(n1,:), [3,1])*R(n2,:);
                Rd = reshape(Rm(:)*R(n3,:),[3, 3, 3]);
                Rdm = reshape(Rd(:)*R(n4,:),[3, 3, 3, 3]);
                
                chi3_cyl(n1,n2,n3,n4) = simplify(sum(Rdm(:,:,:,:).*chi3(:,:,:,:),'all'));
                
            end
        end
    end
end

% Display the transformed tensor
disp(chi3_cyl);
