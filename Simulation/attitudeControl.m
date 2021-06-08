function [Hdb,FdbT,Cdb,Adci] = attitudeControl(Ad,Bd,Cd,Dd,hz)
    pCs = plantConstants;
    Q = pCs.Q;
    S = pCs.S;
    R = pCs.R;
    % Ad6x6  Bd6x3  Cd3x6  Dd3x3
    Aaug_tilde = [Ad Bd;zeros(flip(size(Bd))) eye(size(Bd,2))]; % size(Bd,2) is column #s of Bd  Augtilde:9x9
    Baug_tilde = [Bd;eye(size(Bd,2))];                          % Baugtilde: 9x3
    Caug_tilde = [Cd zeros(size(Cd,1))];                        % size(Cd,1) is raw #s of Cd   Caugtilde: 3x9
    Daug_tilde = Dd;                                            % Daugtilde: 3x3
    
    CtQC = Caug_tilde'*Q*Caug_tilde;
    CtSC = Caug_tilde'*S*Caug_tilde;
    
    QC = Q*Caug_tilde;
    SC = S*Caug_tilde;
    
    Qdb = zeros(hz*size(CtQC));
    Tdb = zeros(hz*size(QC));
    Rdb = zeros(hz*size(R));
    Cdb = zeros(size(Baug_tilde,1)*hz,size(Baug_tilde,2)*hz);
    Adci = zeros(size(Aaug_tilde,1)*hz,size(Aaug_tilde,2));
for i = 1:hz
       if i == hz
           Qdb(1+length(CtSC(:,1))*(i-1):length(CtSC(:,1))*i,1+length(CtSC(1,:))*(i-1):length(CtSC(1,:))*i) = CtSC;
           Tdb(1+length(SC(:,1))*(i-1):length(SC(:,1))*i,1+length(SC(1,:))*(i-1):length(SC(1,:))*i) = SC;
       else
           Qdb(1+length(CtQC(:,1))*(i-1):length(CtQC(:,1))*i,1+length(CtQC(1,:))*(i-1):length(CtQC(1,:))*i) = CtQC;
           Tdb(1+length(QC(:,1))*(i-1):length(QC(:,1))*i,1+length(QC(1,:))*(i-1):length(QC(1,:))*i) = QC;
       end
       Rdb(1+length(R(:,1))*(i-1):length(R(:,1))*i,1+length(R(1,:))*(i-1):length(R(1,:))*i) = R;
       
       
