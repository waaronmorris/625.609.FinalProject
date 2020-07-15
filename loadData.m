function dataMatrix = loadData(table)
    %% This function loads the corona data from a git repository.
    %
    % Input:
    %    table: confirmed, deaths, or recovered
    % Output:
    %    dataMatrix: Matlab Table reflecting JHU Time Series File.

    websave([table,'.csv'], ['https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_',table,'_global.csv']);
    opts = detectImportOptions([table,'.csv']); % Detect import parameters
    % Fix range and delimiter
    opts.DataLines = [2, Inf];
    opts.Delimiter = ",";
    opts.VariableNames(1:4) = [{'ProvinceState'}, {'CountryRegion'}, {'Lat'}, {'Long'}];
    opts.VariableTypes(1:4) = [{'string'}, {'categorical'}, {'double'}, {'double'}];
    % Fix file level properties
    opts.ExtraColumnsRule = "ignore";
    opts.EmptyLineRule = "read";
    % Fix variable properties
    opts = setvaropts(opts, "ProvinceState", "WhitespaceRule", "preserve");
    opts = setvaropts(opts, ["ProvinceState", "CountryRegion"], "EmptyFieldRule", "auto");
    dataMatrix = readtable([table,'.csv'], opts);
end
