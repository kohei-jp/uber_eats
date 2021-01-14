import React from 'react';

// style
import { RoundButton } from '../shared_style';

export const CountUpButton = ({
  onClick,
  isDisabled,
}) => (
  // RoundButtonは、styled_componetsのbutton
  <RoundButton onClick={onClick} disabled={isDisabled}>
    ＋
  </RoundButton>
)