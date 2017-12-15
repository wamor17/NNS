clear all, clc

%	SE LEEN LOS ARCHIVOS CSV QUE CONTIENEN LOS VALORES DE CADA CARACTERISTICA PARA CADA GENERO
metal = csvread('csv/metal.csv');
mexicano = csvread('csv/mexicano.csv');
pop = csvread('csv/pop.csv');
rock = csvread('csv/rock.csv');

% 	TOMAMOS LAS PRIMERAS 30 FILAS DE DATOS DE CADA GENERO PARA LA ETAPA DE ENTRENAMIENTO
maxTraining = 30;
metalTraining = metal(1:maxTraining,:);
mexicanoTraining = mexicano(1:maxTraining,:);
popTraining = pop(1:maxTraining,:);
rockTraining = rock(1:maxTraining,:);

% 	TOMAMOS LAS 10 FILAS RESTANTES DE CADA GENERO, PARA LA ETAPA DE PRUEBAS
minTesting = 31;
metalTesting = metal(minTesting:40,:);
mexicanoTesting = mexicano(minTesting:40,:);
popTesting = pop(minTesting:40,:);
rockTesting = rock(minTesting:40,:);

numberTesting = 10;

%	** ETAPA DE ENTRENAMIENTO **
%	OBTENEMOS EL PROMEDIO DE CADA CARACTERISTICA Y CREAMOS UN PROTOTIPO PARA CADA CLASE Y
%	CREAMOS UN ARCHIVO CSV QUE CONTENDRA LOS PROTOTIPOS PARA LAS CUATRO CLASES
protoClass1 = [mean(metalTraining(:,1)), mean(metalTraining(:,2)), mean(metalTraining(:,3)), mean(metalTraining(:,4)), mean(metalTraining(:,5)), mean(metalTraining(:,6)), mean(metalTraining(:,7)), mean(metalTraining(:,8)), mean(metalTraining(:,9)), mean(metalTraining(:,10)), mean(metalTraining(:,11))];
protoClass2 = [mean(mexicanoTraining(:,1)), mean(mexicanoTraining(:,2)), mean(mexicanoTraining(:,3)), mean(mexicanoTraining(:,4)), mean(mexicanoTraining(:,5)), mean(mexicanoTraining(:,6)), mean(mexicanoTraining(:,7)), mean(mexicanoTraining(:,8)), mean(mexicanoTraining(:,9)), mean(mexicanoTraining(:,10)), mean(mexicanoTraining(:,11))];;
protoClass3 = [mean(popTraining(:,1)), mean(popTraining(:,2)), mean(popTraining(:,3)), mean(popTraining(:,4)), mean(popTraining(:,5)), mean(popTraining(:,6)), mean(popTraining(:,7)), mean(popTraining(:,8)), mean(popTraining(:,9)), mean(popTraining(:,10)), mean(popTraining(:,11))];;
protoClass4 = [mean(rockTraining(:,1)), mean(rockTraining(:,2)), mean(rockTraining(:,3)), mean(rockTraining(:,4)), mean(rockTraining(:,5)), mean(rockTraining(:,6)), mean(rockTraining(:,7)), mean(rockTraining(:,8)), mean(rockTraining(:,9)), mean(rockTraining(:,10)), mean(rockTraining(:,11))];;

prototypes = [protoClass1; protoClass2; protoClass3; protoClass4];
csvwrite('csv/prototypes.csv',prototypes);

%	** ETAPA DE PRUEBAS **
%	CALCULAMOS LA DISTANCIA EUCLIDEANA DE UN ELEMENTO DE PRUEBA A CADA UNA DE LAS CLASES Y
%	LO CLASIFICAMOS DE ACUERDO A DICHO VALOR
correctMetal=0;
correctMexicana=0;
correctPop=0;
correctRock=0;

for i=1:10;
%	NUEVAS NUESTRAS DE LA CLASE 'METAL'
	distMetal_Metal(i) = sqrt( power(protoClass1(1,1)-metalTesting(i,1),2) + power(protoClass1(1,2)-metalTesting(i,2),2) + power(protoClass1(1,3)-metalTesting(i,3),2) + power(protoClass1(1,4)-metalTesting(i,4),2) + power(protoClass1(1,5)-metalTesting(i,5),2) + power(protoClass1(1,6)-metalTesting(i,6),2) + power(protoClass1(1,7)-metalTesting(i,7),2) + power(protoClass1(1,8)-metalTesting(i,8),2) + power(protoClass1(1,9)-metalTesting(i,9),2) + power(protoClass1(1,10)-metalTesting(i,10),2) + power(protoClass1(1,11)-metalTesting(i,11),2) );
	distMetal_Mexicana(i) = sqrt( power(protoClass2(1,1)-metalTesting(i,1),2) + power(protoClass2(1,2)-metalTesting(i,2),2) + power(protoClass2(1,3)-metalTesting(i,3),2) + power(protoClass2(1,4)-metalTesting(i,4),2) + power(protoClass2(1,5)-metalTesting(i,5),2) + power(protoClass2(1,6)-metalTesting(i,6),2) + power(protoClass2(1,7)-metalTesting(i,7),2) + power(protoClass2(1,8)-metalTesting(i,8),2) + power(protoClass2(1,9)-metalTesting(i,9),2) + power(protoClass2(1,10)-metalTesting(i,10),2) + power(protoClass2(1,11)-metalTesting(i,11),2) );
	distMetal_Pop(i) = sqrt( power(protoClass3(1,1)-metalTesting(i,1),2) + power(protoClass3(1,2)-metalTesting(i,2),2) + power(protoClass3(1,3)-metalTesting(i,3),2) + power(protoClass3(1,4)-metalTesting(i,4),2) + power(protoClass3(1,5)-metalTesting(i,5),2) + power(protoClass3(1,6)-metalTesting(i,6),2) + power(protoClass3(1,7)-metalTesting(i,7),2) + power(protoClass3(1,8)-metalTesting(i,8),2) + power(protoClass3(1,9)-metalTesting(i,9),2) + power(protoClass3(1,10)-metalTesting(i,10),2) + power(protoClass3(1,11)-metalTesting(i,11),2) );
	distMetal_Rock(i) = sqrt( power(protoClass4(1,1)-metalTesting(i,1),2) + power(protoClass4(1,2)-metalTesting(i,2),2) + power(protoClass4(1,3)-metalTesting(i,3),2) + power(protoClass4(1,4)-metalTesting(i,4),2) + power(protoClass4(1,5)-metalTesting(i,5),2) + power(protoClass4(1,6)-metalTesting(i,6),2) + power(protoClass4(1,7)-metalTesting(i,7),2) + power(protoClass4(1,8)-metalTesting(i,8),2) + power(protoClass4(1,9)-metalTesting(i,9),2) + power(protoClass4(1,10)-metalTesting(i,10),2) + power(protoClass4(1,11)-metalTesting(i,11),2) );

	if( distMetal_Metal(i) > distMetal_Mexicana(i) && distMetal_Metal(i) > distMetal_Pop(i) && distMetal_Metal(i) > distMetal_Rock(i) )
		clusterSongsMetal(1,i) = '1';
		correctMetal = correctMetal + 1;
	elseif( distMetal_Mexicana(i) > distMetal_Metal(i) && distMetal_Mexicana(i) > distMetal_Pop(i) && distMetal_Mexicana(i) > distMetal_Rock(i) )
		clusterSongsMetal(1,i) = '2';
	elseif( distMetal_Pop(i) > distMetal_Metal(i) && distMetal_Pop(i) > distMetal_Mexicana(i) && distMetal_Pop(i) > distMetal_Rock(i) )
		clusterSongsMetal(1,i) = '3';
	elseif( distMetal_Rock(i) > distMetal_Metal(i) && distMetal_Rock(i) > distMetal_Mexicana(i) && distMetal_Rock(i) > distMetal_Pop(i) )
		clusterSongsMetal(1,i) = '4';
	end

%	NUEVAS NUESTRAS DE LA CLASE 'MEXICANA'
	distMexicana_Metal(i) = sqrt( power(protoClass1(1,1)-mexicanoTesting(i,1),2) + power(protoClass1(1,2)-mexicanoTesting(i,2),2) + power(protoClass1(1,3)-mexicanoTesting(i,3),2) + power(protoClass1(1,4)-mexicanoTesting(i,4),2) + power(protoClass1(1,5)-mexicanoTesting(i,5),2) + power(protoClass1(1,6)-mexicanoTesting(i,6),2) + power(protoClass1(1,7)-mexicanoTesting(i,7),2) + power(protoClass1(1,8)-mexicanoTesting(i,8),2) + power(protoClass1(1,9)-mexicanoTesting(i,9),2) + power(protoClass1(1,10)-mexicanoTesting(i,10),2) + power(protoClass1(1,11)-mexicanoTesting(i,11),2) );
	distMexicana_Mexicana(i) = sqrt( power(protoClass2(1,1)-mexicanoTesting(i,1),2) + power(protoClass2(1,2)-mexicanoTesting(i,2),2) + power(protoClass2(1,3)-mexicanoTesting(i,3),2) + power(protoClass2(1,4)-mexicanoTesting(i,4),2) + power(protoClass2(1,5)-mexicanoTesting(i,5),2) + power(protoClass2(1,6)-mexicanoTesting(i,6),2) + power(protoClass2(1,7)-mexicanoTesting(i,7),2) + power(protoClass2(1,8)-mexicanoTesting(i,8),2) + power(protoClass2(1,9)-mexicanoTesting(i,9),2) + power(protoClass2(1,10)-mexicanoTesting(i,10),2) + power(protoClass2(1,11)-mexicanoTesting(i,11),2) );
	distMexicana_Pop(i) = sqrt( power(protoClass3(1,1)-mexicanoTesting(i,1),2) + power(protoClass3(1,2)-mexicanoTesting(i,2),2) + power(protoClass3(1,3)-mexicanoTesting(i,3),2) + power(protoClass3(1,4)-mexicanoTesting(i,4),2) + power(protoClass3(1,5)-mexicanoTesting(i,5),2) + power(protoClass3(1,6)-mexicanoTesting(i,6),2) + power(protoClass3(1,7)-mexicanoTesting(i,7),2) + power(protoClass3(1,8)-mexicanoTesting(i,8),2) + power(protoClass3(1,9)-mexicanoTesting(i,9),2) + power(protoClass3(1,10)-mexicanoTesting(i,10),2) + power(protoClass3(1,11)-mexicanoTesting(i,11),2) );
	distMexicana_Rock(i) = sqrt( power(protoClass4(1,1)-mexicanoTesting(i,1),2) + power(protoClass4(1,2)-mexicanoTesting(i,2),2) + power(protoClass4(1,3)-mexicanoTesting(i,3),2) + power(protoClass4(1,4)-mexicanoTesting(i,4),2) + power(protoClass4(1,5)-mexicanoTesting(i,5),2) + power(protoClass4(1,6)-mexicanoTesting(i,6),2) + power(protoClass4(1,7)-mexicanoTesting(i,7),2) + power(protoClass4(1,8)-mexicanoTesting(i,8),2) + power(protoClass4(1,9)-mexicanoTesting(i,9),2) + power(protoClass4(1,10)-mexicanoTesting(i,10),2) + power(protoClass4(1,11)-mexicanoTesting(i,11),2) );

	if( distMexicana_Metal(i) > distMexicana_Mexicana(i) && distMexicana_Metal(i) > distMexicana_Pop(i) && distMexicana_Metal(i) > distMexicana_Rock(i) )
		clusterSongsMexicana(1,i) = '1';
	elseif( distMexicana_Mexicana(i) >= distMexicana_Metal(i) && distMexicana_Mexicana(i) >= distMexicana_Pop(i) && distMexicana_Mexicana(i) >= distMexicana_Rock(i) )
		clusterSongsMexicana(1,i) = '2';
		correctMexicana = correctMexicana + 1;
	elseif( distMexicana_Pop(i) > distMexicana_Metal(i) && distMexicana_Pop(i) > distMexicana_Mexicana(i) && distMexicana_Pop(i) > distMexicana_Rock(i) )
		clusterSongsMexicana(1,i) = '3';
	elseif( distMexicana_Rock(i) > distMexicana_Metal(i) && distMexicana_Rock(i) > distMexicana_Mexicana(i) && distMexicana_Rock(i) > distMexicana_Pop(i) )
		clusterSongsMexicana(1,i) = '4';
	end

%	NUEVAS MUESTRAS DE LA CLASE 'POP'
	distPop_Metal(i) = sqrt( power(protoClass1(1,1)-popTesting(i,1),2) + power(protoClass1(1,2)-popTesting(i,2),2) + power(protoClass1(1,3)-popTesting(i,3),2) + power(protoClass1(1,4)-popTesting(i,4),2) + power(protoClass1(1,5)-popTesting(i,5),2) + power(protoClass1(1,6)-popTesting(i,6),2) + power(protoClass1(1,7)-popTesting(i,7),2) + power(protoClass1(1,8)-popTesting(i,8),2) + power(protoClass1(1,9)-popTesting(i,9),2) + power(protoClass1(1,10)-popTesting(i,10),2) + power(protoClass1(1,11)-popTesting(i,11),2) );
	distPop_Mexicana(i) = sqrt( power(protoClass2(1,1)-popTesting(i,1),2) + power(protoClass2(1,2)-popTesting(i,2),2) + power(protoClass2(1,3)-popTesting(i,3),2) + power(protoClass2(1,4)-popTesting(i,4),2) + power(protoClass2(1,5)-popTesting(i,5),2) + power(protoClass2(1,6)-popTesting(i,6),2) + power(protoClass2(1,7)-popTesting(i,7),2) + power(protoClass2(1,8)-popTesting(i,8),2) + power(protoClass2(1,9)-popTesting(i,9),2) + power(protoClass2(1,10)-popTesting(i,10),2) + power(protoClass2(1,11)-popTesting(i,11),2) );
	distPop_Pop(i) = sqrt( power(protoClass3(1,1)-popTesting(i,1),2) + power(protoClass3(1,2)-popTesting(i,2),2) + power(protoClass3(1,3)-popTesting(i,3),2) + power(protoClass3(1,4)-popTesting(i,4),2) + power(protoClass3(1,5)-popTesting(i,5),2) + power(protoClass3(1,6)-popTesting(i,6),2) + power(protoClass3(1,7)-popTesting(i,7),2) + power(protoClass3(1,8)-popTesting(i,8),2) + power(protoClass3(1,9)-popTesting(i,9),2) + power(protoClass3(1,10)-popTesting(i,10),2) + power(protoClass3(1,11)-popTesting(i,11),2) );
	distPop_Rock(i) = sqrt( power(protoClass4(1,1)-popTesting(i,1),2) + power(protoClass4(1,2)-popTesting(i,2),2) + power(protoClass4(1,3)-popTesting(i,3),2) + power(protoClass4(1,4)-popTesting(i,4),2) + power(protoClass4(1,5)-popTesting(i,5),2) + power(protoClass4(1,6)-popTesting(i,6),2) + power(protoClass4(1,7)-popTesting(i,7),2) + power(protoClass4(1,8)-popTesting(i,8),2) + power(protoClass4(1,9)-popTesting(i,9),2) + power(protoClass4(1,10)-popTesting(i,10),2) + power(protoClass4(1,11)-popTesting(i,11),2) );

	if( distPop_Metal(i) > distPop_Mexicana(i) && distPop_Metal(i) > distPop_Pop(i) && distPop_Metal(i) > distPop_Rock(i) )
		clusterSongsPop(1,i) = '1';
	elseif( distPop_Mexicana(i) > distPop_Metal(i) && distPop_Mexicana(i) > distPop_Pop(i) && distPop_Mexicana(i) > distPop_Rock(i) )
		clusterSongsPop(1,i) = '2';
	elseif( distPop_Pop(i) > distPop_Metal(i) && distPop_Pop(i) > distPop_Mexicana(i) && distPop_Pop(i) > distPop_Rock(i) )
		clusterSongsPop(1,i) = '3';
		correctPop = correctPop + 1;
	elseif( distPop_Rock(i) > distPop_Metal(i) && distPop_Rock(i) > distPop_Mexicana(i) && distPop_Rock(i) > distPop_Pop(i) )
		clusterSongsPop(1,i) = '4';
	end

%	NUEVAS MUESTRAS DE LA CLASE 'ROCK'
	distRock_Metal(i) = sqrt( power(protoClass1(1,1)-rockTesting(i,1),2) + power(protoClass1(1,2)-rockTesting(i,2),2) + power(protoClass1(1,3)-rockTesting(i,3),2) + power(protoClass1(1,4)-rockTesting(i,4),2) + power(protoClass1(1,5)-rockTesting(i,5),2) + power(protoClass1(1,6)-rockTesting(i,6),2) + power(protoClass1(1,7)-rockTesting(i,7),2) + power(protoClass1(1,8)-rockTesting(i,8),2) + power(protoClass1(1,9)-rockTesting(i,9),2) + power(protoClass1(1,10)-rockTesting(i,10),2) + power(protoClass1(1,11)-rockTesting(i,11),2) );
	distRock_Mexicana(i) = sqrt( power(protoClass2(1,1)-rockTesting(i,1),2) + power(protoClass2(1,2)-rockTesting(i,2),2) + power(protoClass2(1,3)-rockTesting(i,3),2) + power(protoClass2(1,4)-rockTesting(i,4),2) + power(protoClass2(1,5)-rockTesting(i,5),2) + power(protoClass2(1,6)-rockTesting(i,6),2) + power(protoClass2(1,7)-rockTesting(i,7),2) + power(protoClass2(1,8)-rockTesting(i,8),2) + power(protoClass2(1,9)-rockTesting(i,9),2) + power(protoClass2(1,10)-rockTesting(i,10),2) + power(protoClass2(1,11)-rockTesting(i,11),2) );
	distRock_Pop(i) = sqrt( power(protoClass3(1,1)-rockTesting(i,1),2) + power(protoClass3(1,2)-rockTesting(i,2),2) + power(protoClass3(1,3)-rockTesting(i,3),2) + power(protoClass3(1,4)-rockTesting(i,4),2) + power(protoClass3(1,5)-rockTesting(i,5),2) + power(protoClass3(1,6)-rockTesting(i,6),2) + power(protoClass3(1,7)-rockTesting(i,7),2) + power(protoClass3(1,8)-rockTesting(i,8),2) + power(protoClass3(1,9)-rockTesting(i,9),2) + power(protoClass3(1,10)-rockTesting(i,10),2) + power(protoClass3(1,11)-rockTesting(i,11),2) );
	distRock_Rock(i) = sqrt( power(protoClass4(1,1)-rockTesting(i,1),2) + power(protoClass4(1,2)-rockTesting(i,2),2) + power(protoClass4(1,3)-rockTesting(i,3),2) + power(protoClass4(1,4)-rockTesting(i,4),2) + power(protoClass4(1,5)-rockTesting(i,5),2) + power(protoClass4(1,6)-rockTesting(i,6),2) + power(protoClass4(1,7)-rockTesting(i,7),2) + power(protoClass4(1,8)-rockTesting(i,8),2) + power(protoClass4(1,9)-rockTesting(i,9),2) + power(protoClass4(1,10)-rockTesting(i,10),2) + power(protoClass4(1,11)-rockTesting(i,11),2) );

	if( distRock_Metal(i) > distRock_Mexicana(i) && distRock_Metal(i) > distRock_Pop(i) && distRock_Metal(i) > distRock_Rock(i) )
		clusterSongsRock(1,i) = '1';
	elseif( distRock_Mexicana(i) > distRock_Metal(i) && distRock_Mexicana(i) > distRock_Pop(i) && distRock_Mexicana(i) > distRock_Rock(i) )
		clusterSongsRock(1,i) = '2';
	elseif( distRock_Pop(i) > distRock_Metal(i) && distRock_Pop(i) > distRock_Mexicana(i) && distRock_Pop(i) > distRock_Rock(i) )
		clusterSongsRock(1,i) = '3';
	elseif( distRock_Rock(i) > distRock_Metal(i) && distRock_Rock(i) > distRock_Mexicana(i) && distRock_Rock(i) > distRock_Pop(i) )
		clusterSongsRock(1,i) = '4';
		correctRock = correctRock + 1;
	end
end

%	LIMPIAMOS LA CONSOLA
system('clear');

fprintf('\n\n\t\t\t\t ***** CLASIFICACION DE CANCIONES POR GENERO ***** \n');
fprintf('\t\t\t     ***** UTILIZANDO EL ALGORITMO DEL VECINO MAS CERCANO ***** \n');
fprintf('\n\t\t\t\t\t *** PLAYLIST HEAVY METAL *** \n\n');
fprintf(' Correctas = %.2f porciento \n Incorrectas = %.2f porciento \n\n', (correctMetal*100)/10, ((10-correctMetal)*100)/10);
fprintf('  Clasificados incorrectamente: \n\n');
fprintf('  No. \t\t\t\t\t\t Caracteristicas \n\n');

for i=1:numberTesting;
	if( clusterSongsMetal(i) != '1' )
		fprintf('   %i     %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f \n',i, metalTesting(1,1), metalTesting(1,2), metalTesting(1,3), metalTesting(1,4), metalTesting(1,5), metalTesting(1,6), metalTesting(1,7), metalTesting(1,8), metalTesting(1,9), metalTesting(1,10), metalTesting(1,11));
	end
end


fprintf('\n\n\t\t\t\t\t *** PLAYLIST MEXICANA *** \n\n');
fprintf(' Correctas = %.2f porciento \n Incorrectas = %.2f porciento \n\n', (correctMexicana*100)/10, ((10-correctMexicana)*100)/10);
fprintf('  Clasificados incorrectamente: \n\n');
fprintf('  No. \t\t\t\t\t\t Caracteristicas \n\n');

for i=1:numberTesting;
	if( clusterSongsMexicana(i) != '2' )
		fprintf('   %i     %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f \n',i, mexicanoTesting(1,1), mexicanoTesting(1,2), mexicanoTesting(1,3), mexicanoTesting(1,4), mexicanoTesting(1,5), mexicanoTesting(1,6), mexicanoTesting(1,7), mexicanoTesting(1,8), mexicanoTesting(1,9), mexicanoTesting(1,10), mexicanoTesting(1,11));
	end
end

fprintf('\n\n\t\t\t\t\t *** PLAYLIST POP *** \n\n');
fprintf(' Correctas = %.2f porciento \n Incorrectas = %.2f porciento \n\n', (correctPop*100)/10, ((10-correctPop)*100)/10);
fprintf('  No. \t\t\t\t\t\t Caracteristicas \n\n');

for i=1:numberTesting;
	if( clusterSongsPop(i) != '3' )
		fprintf('   %i     %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f \n',i, popTesting(1,1), popTesting(1,2), popTesting(1,3), popTesting(1,4), popTesting(1,5), popTesting(1,6), popTesting(1,7), popTesting(1,8), popTesting(1,9), popTesting(1,10), popTesting(1,11));
	end
end

fprintf('\n\n\t\t\t\t\t *** PLAYLIST ROCK *** \n\n');
fprintf(' Correctas = %.2f porciento \n Incorrectas = %.2f porciento \n\n', (correctRock*100)/10, ((10-correctRock)*100)/10);
fprintf('  Clasificados incorrectamente: \n\n');
fprintf('  No. \t\t\t\t\t\t Caracteristicas \n\n');

for i=1:numberTesting;
	if( clusterSongsRock(i) != '4' )
		fprintf('   %i     %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f,  %.4f \n',i, rockTesting(1,1), rockTesting(1,2), rockTesting(1,3), rockTesting(1,4), rockTesting(1,5), rockTesting(1,6), rockTesting(1,7), rockTesting(1,8), rockTesting(1,9), rockTesting(1,10), rockTesting(1,11));
	end
end

correctasTotal = ((correctMetal*100)/10 + (correctMexicana*100)/10 + (correctPop*100)/10 + (correctRock*100)/10)/4;
incorrectasTotal = (((10-correctMetal)*100)/10 + ((10-correctMexicana)*100)/10 + ((10-correctPop)*100)/10 + ((10-correctRock)*100)/10)/4;
fprintf('\n\n  Porcentajes generales \n\n  Correctas = %.2f porciento \n  Incorrectas %.2f porciento \n',correctasTotal, incorrectasTotal);


fprintf('\n\n\n\n\n\n\n\n');

