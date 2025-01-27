package ltd.prawn.service.implement;

import ltd.prawn.dao.PrawnUserMapper;
import ltd.prawn.entity.PrawnUserEntity;
import ltd.prawn.service.PrawnUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service("prawn.user.service.imp")
public class PrawnUserServiceImp implements PrawnUserService {
    @Autowired
    PrawnUserMapper userMapper;
    @Override
    public PrawnUserEntity getUserInfoById(Long userID) {
        assert userID > 0;
        PrawnUserEntity entity = userMapper.selectByPrimaryKey(userID);
        return entity;
    }

    @Override
    public int insertUser(PrawnUserEntity pe) {
        assert !pe.getName().isEmpty();
        int result = userMapper.insert(pe);
        return result;
    }




}
