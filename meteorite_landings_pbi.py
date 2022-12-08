# pbi_args = []
# pbi_args = [(-71.5, 35.67),(-72, 26),(28.854,12.52233),(-84, 168)]

import reverse_geocoder as rg
import pandas as pd

if __name__ == '__main__':    

    if len(pbi_args) == 0:
        pbi_args = [(50.75,6.08333)]
 
    coordinates = pbi_args

    location_info = pd.DataFrame(columns = ['cc', 'admin1', 'admin2'], index = pbi_args)
    rg_result = rg.search(coordinates)

    for idx, result in enumerate(rg_result):
        result_list = []

        # Antarctica corrections
        if pbi_args[idx][0] <= -70:
            result_list.append('AQ')
            result_list.append('')
            result_list.append('')
        else:
            result_list.append(result['cc'])
            result_list.append(result['admin1'])
            result_list.append(result['admin2'])

        location_info.iloc[idx] = result_list

    location_info.reset_index(inplace=True)
    location_info.rename(columns={"index": "geolocation"}, inplace=True)
    location_info.drop_duplicates(inplace=True)

    print(location_info)