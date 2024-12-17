package ltd.prawn.service;

import ltd.prawn.entity.PrawnUserEntity;

public interface PrawnUserService {
    /// Get User By ID
    PrawnUserEntity getUserInfoById(Long userID);
}
