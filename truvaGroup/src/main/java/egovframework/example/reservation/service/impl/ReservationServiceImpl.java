package egovframework.example.reservation.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import egovframework.example.reservation.service.ReservationService;
import egovframework.example.reservation.service.ReservationVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service("reservationService")
public class ReservationServiceImpl extends EgovAbstractServiceImpl implements ReservationService{

	@Resource(name = "reservationMapper")
	private ReservationMapper reservationMapper;

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectTemaList() throws Exception {
		
		return reservationMapper.getSelectTemaList();
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectPayList() throws Exception {

		return reservationMapper.getSelectPayList();
	}
	
	@Transactional(rollbackFor=Exception.class)
	public void saveReservationInfo(ReservationVO reservationVO)
			throws Exception {
		
		try {
			reservationMapper.saveReservation(reservationVO);
			reservationMapper.saveOrder(reservationVO);
			reservationMapper.updateProd(reservationVO);
			try {

				// 마일리지를 사용했으면
				if (!(reservationVO.getUsePoint().equals("0"))) {

					reservationMapper.useMyPoint(reservationVO);
				}
				
				if (reservationVO.getProdGubun().equals("버스")) {
					
					reservationMapper.updateSeat(reservationVO);
				}
				
				if (!(reservationVO.getCouponNumber().equals(""))) {
					
					reservationMapper.useCoupon(reservationVO);
				}
			} catch (Exception ex) {
				
				throw ex;
			}
		} catch (Exception e) {
			
			throw e;
		}
	}

	@Override
	public EgovMap selectresInfo(ReservationVO reservationVO)
			throws Exception {
		
		return reservationMapper.resInfo(reservationVO);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> selectCoupon(String param) throws Exception {

		return reservationMapper.getSelectCoupon(param);
	}

	@Override
	public EgovMap selectMyPoint(String memberNum) throws Exception {

		return reservationMapper.selectMyPoint(memberNum);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List<Map> getProductList(Map castMap) throws Exception {

		return reservationMapper.getProductList(castMap);
	}

	@Override
	public EgovMap selectGetBusSeat(String param) throws Exception {

		return reservationMapper.selectGetBusSeat(param);
	}

	@Override
	public EgovMap getSeatInfo(String prodNm) throws Exception {

		return reservationMapper.getSeatInfo(prodNm);
	}
}