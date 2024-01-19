clc;
clear all;
close all;


       %DIVIDING DATASET INTO TEST TRAIN AND VAL
%=======================================================
%Loading all desert Images and Giving them Label 1
desertImages = dir(fullfile('Data\Desert', '*.jpg'));
desertLabels = ones(length(desertImages), 1); 

%Loading all forest Images and Giving them Label 0
forestImages = dir(fullfile('Data\Forest', '*.jpg'));
forestLabels = zeros(length(forestImages), 1);

%Here Combining the desert and forest datasets
allImages = [desertImages; forestImages];  
allLabels = [desertLabels; forestLabels];

% Shuffling the dataset
rng(42); % Set a random seed for reproducibility
shuffledIndices = randperm(length(allImages));
shuffledImages = allImages(shuffledIndices);
shuffledLabels = allLabels(shuffledIndices);

% Split the dataset into training, validation, and test sets
trainRatio = 0.7;
valRatio = 0.15;
testRatio = 0.15;

totalImages = length(shuffledImages);
numTrain = round(trainRatio * totalImages); %No. of training examples
numVal = round(valRatio * totalImages);     %No. of validation examples

trainImages = shuffledImages(1:numTrain); 
Ytrain = shuffledLabels(1:numTrain);

valImages = shuffledImages(numTrain + 1:numTrain + numVal);
Yval = shuffledLabels(numTrain + 1:numTrain + numVal);

testImages = shuffledImages(numTrain + numVal + 1:end);
Ytest = shuffledLabels(numTrain + numVal + 1:end);
fprintf('Dataset is Divided Successfully in training , test and Validation\n');
fprintf('No. of training examples:   %f\n',numTrain);
fprintf('No. of Validation examples: %f\n',numVal);
fprintf('No. of test examples:       %f\n',totalImages-numTrain-numVal);
fprintf('\n\n');


      %FOR RGB IMAGES TRAINING THE MODEL
%============================================%

%Features vector
Xtrain_rgb=fun1rgb(trainImages);
Xtest_rgb=fun1rgb(testImages);
Xval_rgb=fun1rgb(valImages);
%So Now we have X and Y Vectors and can apply logistic regression and
%obtain optimal value of theta using fmincg

fprintf('Training the model to find optimal theta value using RGB array........');
[m, n] = size(Xtrain_rgb);
initial_theta = zeros(n , 1);
lambda = 0.1;
options = optimset('GradObj', 'on', 'MaxIter', 400);
costFunction = @(t)(costFunctionReg(t, Xtrain_rgb, Ytrain, lambda));
theta = fmincg(costFunction, initial_theta, options);
%We have obtained optimal theta now lets pridict values for test dataset
fprintf('Model is trained Using rgb Array\n');
fprintf('Press Enter to check Accuracy\n');
pause;
p = predict(theta, Xtest_rgb);
[ CON,A,P, R, F1 ] = confusionmatrix(p,Ytest);

display('Confusion Matrix is :');
display(CON);
fprintf('Accuracy of model is: %f\n',A);
fprintf('F1 Score is: %f\n',F1);
fprintf('\n\n');


%FOR GRAYSCALE IMAGES TRAINING THE MODEL
%============================================%
fprintf('Now Training the model to find optimal theta value using grayscale array........');

%Features vector
Xtrain_gray=fun2gray(trainImages);
Xtest_gray=fun2gray(testImages);
Xval_gray=fun2gray(valImages);
%So Now we have X and Y Vectors and can apply logistic regression and
%obtain optimal value of theta using fmincg

[m, n] = size(Xtrain_gray);
initial_theta = zeros(n , 1);
lambda = 0.1;
options = optimset('GradObj', 'on', 'MaxIter', 400);
costFunction = @(t)(costFunctionReg(t, Xtrain_gray, Ytrain, lambda));
theta = fmincg(costFunction, initial_theta, options);
%We have obtained optimal theta now lets pridict values for test dataset
fprintf('Model is trained using grayscale array\n');
fprintf('Press Enter to check Accuracy\n');
pause;

p = predict(theta, Xtest_gray);
[ CON,A,P, R, F1 ] = confusionmatrix(p,Ytest);

display('Confusion Matrix is :');
display(CON);
fprintf('Accuracy of model is: %f\n',A);
fprintf('F1 Score is: %f\n',F1);


