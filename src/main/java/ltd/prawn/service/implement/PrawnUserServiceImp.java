package ltd.prawn.service.implement;

import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.PrawnUserService;
import org.springframework.stereotype.Service;

@Service("prawn.user.service.imp")
public class PrawnUserServiceImp implements PrawnUserService {
    @Override
    public PrawnUserEntity getUserInfoById(Long userID) {
        PrawnUserEntity entity = new PrawnUserEntity();
        entity.setUserId(1111L);
        return entity;
    }
}
