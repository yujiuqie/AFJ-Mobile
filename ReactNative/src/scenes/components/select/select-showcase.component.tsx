import React, { useState, useCallback } from 'react';
import { StyleSheet } from 'react-native';
import {
  Select,
  SelectElement,
  SelectProps,
  SelectItem,
  SelectGroup,
} from '@ui-kitten/components';
import { SelectOptionType } from './type';

interface SelectCustomProps extends SelectProps {
  data: SelectOptionType[];
  multiSelect?: boolean;
  groupedOptions?: boolean;
}

export const SelectShowcase = (props: SelectCustomProps): SelectElement => {
  const [selectedIndex, setSelectedIndex] = useState<any>(props.selectedIndex);

  const renderOption = useCallback(
    (item, index) => <SelectItem title={item.title} key={index} />,
    []
  );

  const renderGroup = useCallback(
    (item, index) => (
      <SelectGroup title={item.title} key={index}>
        {item.items.map(renderOption)}
      </SelectGroup>
    ),
    []
  );

  const displayValue = () =>
    props.groupedOptions
      ? props.data[selectedIndex.section].items[selectedIndex.row].title
      : props.data[selectedIndex.row].title;

  return (
    <>
      <Select
        {...props}
        value={selectedIndex && displayValue()}
        selectedIndex={selectedIndex}
        onSelect={(index) => setSelectedIndex(index)}
        style={styles.select}
      >
        {props.groupedOptions
          ? props.data.map(renderGroup)
          : props.data.map(renderOption)}
      </Select>
    </>
  );
};

const styles = StyleSheet.create({
  select: {
    width: 200,
  },
});
