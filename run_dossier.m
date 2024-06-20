clc, clear, close

% need to delete the dossier.pdf file (if it exists), since the dossiers
% for each pattern are appended to the existing dossier.pdf file

generate_dossier_pdf("lines");
generate_dossier_pdf("shifted_lines");
generate_dossier_pdf("grid");
generate_dossier_pdf("s");
generate_dossier_pdf("hexagon");
generate_dossier_pdf("octagon");
generate_dossier_pdf("hilbert_curve");
generate_dossier_pdf("sierpinski_curve");
generate_dossier_pdf("peano_curve");
generate_dossier_pdf("gosper_curve");